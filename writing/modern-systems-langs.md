---
title: Modern Systems Languages
author:
  - Sam Stevens
keywords:
  [languages, programming languages, c, c++, rust, dlang, nim, v, zig, ziglang]
abstract: Can we ever improve on C?
---

# Modern Systems Languages

I mostly write Python code, and smarter people than me have written all the performant stuff for Python in C, or [Rust](https://github.com/huggingface/tokenizers), or something else entirely.
But sometimes I need to write some fast code for use with Python.
The last time, it was a diffing algorithm that I needed to be fast (should've just used [fastdiff](https://github.com/syrusakbary/fastdiff) I guess).
The next time, it'll probably be strings again because I would use [NumPy](https://numpy.org/) for basically anything with numbers.

The point is, sometimes I need to write fast, compiled code.
But the important part is being able to use that fast, compiled code in my slow, interpeted Python.
And ideally, I don't have to run a subprocess.
Otherwise, I could just write my data to a file, then write a standalone tool, then write the processed data back to a file...that seems like a much better idea than learning a systems language.
Whatever.

I also don't really want to go back to writing a language without any help from the computer.
MyPy, Elm, Go, VSCode and TypeScript have all spoiled me.
I want to write code with good tooling.
Language servers, or at fast compiler, or amazing error messages; I want a development experience that feels like 2020.

## The Criteria

1. Performance. I'm not writing code in a different language just for it to be as slow as Python.
2. Ease of use. I really want to just install the compiler and start coding.
3. Dynamic libraries (I think). I think the easiest way to interface with Python is to create a shared object file, then use `ctypes` to load the library in Python. If I have to write a thin Python wrapper or a `.pyi` file so I get autocomplete, I'm ok with that.[^improvement?]

That's all I need. I'm willing to learn any syntax, battle any borrow checker, as long as I can write fast code with a decent editor that I can use in Python later on.

[^improvement?]: Is there a better way to interface with Python? How does everyone else write fast code for Python?

## The List

1. C (_The Head Honcho_)
2. Rust (_I should've learned this already_)
3. Zig (_Rust is to C++ as Zig is to C_)
4. Nim (_Python's syntax but it compiles_)
5. D (_C with a GC?_)

## C (_The Head Honcho_)

The reigning champ. I already [wrote about how to make faster Python code with ctypes](https://samuelstevens.me/writing/optimizing-python-code-with-ctypes).
It's very doable.
The only problem is that I'm writing C, and it's been nearly 50 years, and while the language has been improved, there are parts that are still awful to use (null-terminated strings, for example).

## Rust (_I should've learned this already_)

I really should be using Rust already.
Modern systems language, helpful compiler, very mature compared to some other options on this list, includes some functional programming concepts that make me jealous in Python; all good reasons to use Rust.
It just looks a little complicated.
I guess I could use [maturin](https://github.com/PyO3/maturin), but then I have another third party dependency, which is disappointing.

## Zig (_Rust is to C++ as Zig is to C_)

## Nim (_Python's syntax but it compiles_)

## D (_C with a GC?_)
