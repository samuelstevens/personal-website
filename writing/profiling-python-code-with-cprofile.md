---
title: Profiling Python with cProfile
author:
    - Sam Stevens
keywords: [python, profiling, profile, cProfile, cprofile, cpython, fast, faster]
abstract: How to profile Python code with `cProfile`.
---

# Profiling Python Code with `cProfile`

Python is an interpreted language, which typically makes it slower than compiled languages like C/C++, Java, Rust, or Go. In order to [optimize Python code](/writing/optimizing-python-code-with-ctypes) for speed, it's best to know what parts to optimize. That's where `cProfile` comes in.

## cProfile

`cProfile` is a module profiling Python code running in a CPython environment. It can be run as a command-line module, or used in your source code to pinpoint a specific function.

### From the Commmand Line

Run your program as you normally would, but wrap it in [`cProfile`](https://docs.python.org/3/library/profile.html#module-cProfile):

1. Outputs all function calls sorted by internal time.

```bash
    python -m cProfile -s tottime writing.py
```

2. Outputs all function calls sorted by internal time and sends it to `writing.txt` for later inspection.

```bash
    python -m cProfile -s tottime writing.py > writing.txt
```

3. Outputs all function calls to `writing.prof` to be used by another tool later on.

```bash
    python -m cProfile -o writing.prof writing.py
```

### As a Module

Additionally, `cProfile` can be used from inside your source code like so:

```python
cProfile.run("eval(arg1, arg2)", sort='tottime', filename='eval.prof')
```
The only downside of this is that the first argument is a string that is evaluated by `cProfile` instead of passing a function and some arguments. Other than that, it works in exactly the same manner.

Regardless of how you use it, the output from these `cProfile` tools is *loooong*. It can be read, but its often easier to use it in another tool. Python has support for this with the [`pstats.Stats`](https://docs.python.org/3/library/profile.html#pstats.Stats) class.

## Visualizing Profiling Data with SnakeViz

[SnakeViz](https://jiffyclub.github.io/snakeviz/) is a small open-source tool that was recently very valuable to visualizing profiling data. It presents a graph that shows a breakdown by time per function, and allows you to drill down into what causes the length of each function:

![Icicle graph from SnakeViz](/images/python/snakeviz-icicle.png)

From here, you can see what functions take the most time, and what causes each function to take so long. If you can further optimize from here (removing things from loops, using list comprehensions, etc., do so now).

Please [email me](mailto:samuel.robert.stevens@gmail.com) if you have any comments or want to discuss further.