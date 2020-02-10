---
title: Optimizing Python Code with ctypes
author:
    - Sam Stevens
keywords: [python, optimization, optimizing, ctypes, cpython, fast, faster]
abstract: How to connect C and Python code with `ctypes`
---

# Guide: Optimizing Python Code with `ctypes`

<!-- Once you've [profiled your Python](/writing/profiling-python-code-with-cprofile) to highlight bottlenecks, one way to optimize Python is to rewrite slow Python functions in C and call them with `ctypes`. -->

> Note: the code in this post is licensed under [GNU AGPLv3](/license-gnu).

I wrote this guide when I couldn't find one for using `ctypes` all in one place. Hopefully this makes someone else's life much easier.

## Table of Contents:

1. [Basic optimizations](#basic-optimizations)
2. [`ctypes`](#ctypes)
3. [Compiling for Python](#compiling-c-code-for-python)
4. [Structs in Python](#structs-in-python)
5. [Calling Your C Code](#calling-your-c-code)
6. [PyPy](#extra-credit-pypy)

## Basic Optimizations

Before rewriting Python source code in C, consider these standard Python optimizations.

### Built-in Data Structures

The built-in data structures in Python like `set` and `dict` are written in C. They are much faster than writing your own data structures as Python classes. Other data structures besides the standard `set`, `dict`, `list`, and `tuple` are documented in the [`collections` module](https://docs.python.org/dev/library/collections.html#module-collections).

### List Comprehensions

Rather than appending to a list, use list comprehensions. 

```python
# Slow
mapped = []
for value in originallist:
    mapped.append(myfunc(value))

# Faster
mapped = [myfunc(value) in originallist]
```

## `ctypes`

[`ctypes`](https://docs.python.org/3/library/ctypes.html) is a module that allows you to communicate with C code from your Python code without using `subprocess` or similar modules to run another process from the CLI. 

There are two parts: compiling your C code to be loaded as a shared object, and setting up the data structures in your Python code to map to C-types.

In this post, I'll be connecting my Python code to [lcs.c](/lcs-source), which finds the longest common subsequence of two lists of strings. In the Python code, I want this to happen:

```python
list1 = ['My', 'name', 'is', 'Sam', 'Stevens', '!']
list2 = ['My', 'name', 'is', 'Alex', 'Stevens', '.']

common = lcs(list1, list2)

print(common)
# ['My', 'name', 'is', 'Stevens']
```

Some challenges with this particular C function is function signature having lists of strings as the argument types, and the return type not having a fixed length. I solve this with a `Sequence` struct containing the pointers and the length.

### Compiling C code for Python

First, the C source code (`lcs.c`) is compiled to `lcs.so` that can be loaded by Python.

```bash
gcc -c -Wall -Werror -fpic -O3 lcs.c -o lcs.o
gcc -shared -o lcs.so lcs.o
```

* `-Wall` show all warnings.
* `-Werrow` turns all warnings into errors.
* `-fpic` generates "position independent instructions", which is necessary if you want to use this library with Python.
* `-O3` maximizes optimizations.

Next, we begin to write the Python code to use this shared object file. 

### Structs in Python

Below, I show the two structs that are used in my C source code.

```c
struct Sequence
{
    char **items;
    int length;
};

struct Cell
{
    int index;
    int length;
    struct Cell *prev;
};
```

Here, you see the Python translation of the structs.

```python
import ctypes
class SEQUENCE(ctypes.Structure):
    _fields_ = [('items', ctypes.POINTER(ctypes.c_char_p)),
                ('length', ctypes.c_int)]

class CELL(ctypes.Structure):
    pass

CELL._fields_ = [('index', ctypes.c_int), ('length', ctypes.c_int),
                 ('prev', ctypes.POINTER(CELL))]
```
Some notes:

* All structs are `class`es that inherit from `ctypes.Structure`.
* The only field is `_fields_`, which is a list of tuples. Each tuple is `(<variable-name>, <ctypes.TYPE>)`. 
* `ctypes` has types like `c_char` (`char`), and `c_char_p` (`*char`).
* `ctypes` also includes `POINTER()` which creates a pointer type from any type passed to it. 
* If you have a recursive definition like in `CELL`, you must `pass` the initial declaration and then add the `_fields_` fields to reference itself later. 
* Since I didn't use `CELL` in my Python code, I didn't need to write this struct out, but it has a an interesting feature in the recursive field.

### Calling Your C Code

Additionally, I needed some code to convert your Python types to your new C structs. Finally, you can use your new C function to speed up your Python code.

```python
def list_to_SEQUENCE(strlist: List[str]) -> SEQUENCE:
    bytelist = [bytes(s, 'utf-8') for s in strlist]
    arr = (ctypes.c_char_p * len(bytelist))()
    arr[:] = bytelist
    return SEQUENCE(arr, len(bytelist))


def lcs(s1: List[str], s2: List[str]) -> List[str]:
    seq1 = list_to_SEQUENCE(s1)
    seq2 = list_to_SEQUENCE(s2)

    # struct Sequence *lcs(struct Sequence *s1, struct Sequence *s2)
    common = lcsmodule.lcs(ctypes.byref(seq1), ctypes.byref(seq2))[0]

    ret = []

    for i in range(common.length):
        ret.append(common.items[i].decode('utf-8'))
    lcsmodule.freeSequence(common)

    return ret

lcsmodule = ctypes.cdll.LoadLibrary('lcsmodule/lcs.so')
lcsmodule.lcs.restype = ctypes.POINTER(SEQUENCE)

list1 = ['My', 'name', 'is', 'Sam', 'Stevens', '!']
list2 = ['My', 'name', 'is', 'Alex', 'Stevens', '.']

common = lcs(list1, list2)

print(common)
# ['My', 'name', 'is', 'Stevens']
```

More notes:

* `**char` (a list of strings) maps directly to a list of bytes in Python.
* `lcs.c` has a function `lcs()` with the signature: `struct Sequence *lcs(struct Sequence *s1, struct Sequence *s2)`. To get the return type set up, I use `lcsmodule.lcs.restype = ctypes.POINTER(SEQUENCE)`.
* To make a call with the reference to the `struct Sequence`, I use `ctypes.byref()` which returns a "light-weight pointer" to your object (faster than `ctypes.POINTER()`).
* `common.items` is a list of bytes, so they are decoded to get `ret` to be a list of `str`. 
* `lcsmodule.freeSequence(common)` simply frees the memory associated with `common`. This is **critical**, because it will not be automatically collected by the garbage collector (AFAIK).

Optimized Python code: code that you wrote in C and wrote a wrapper for in Python.

## Extra Credit: PyPy

> NOTE: I've never used PyPy personally.

One simple optimization is simply to run your programs in the [PyPy](https://www.pypy.org/) runtime, which includes a just-in-time (JIT) compiler which will speed your loops by compiling them into native code when they run many times.

Please [email me](mailto:samuel.robert.stevens@gmail.com) if you have any comments or want to discuss further.