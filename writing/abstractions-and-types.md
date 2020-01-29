---
title: Abstractions and Types
author:
    - Sam Stevens
keywords: [programming, abstractions, types, functions, languages]
abstract: Why types are an abstraction that you should take advantage of.
---

# Abstractions and Types

Abstraction in programming is a powerful tool that lets us make larger systems with fewer lines of code. 

Functions are the easiest example of an abstraction. Not all abstractions are good (see [the law of leaky abstractions](https://www.joelonsoftware.com/2002/11/11/the-law-of-leaky-abstractions/)) but having rock-solid abstractions is very useful (see [practical magic](https://sites.google.com/site/steveyegge2/practical-magic)).

In addition to functions, types are an abstraction. Your variables don't always have to be `int`, even if that's what they're represented as. For example, `time_t` is often just an `int`, but functions like `time()` return `time_t`, **not** `int`.

Historically (as far as I understand), types were important so the computer knew how much space to allocate for a variable. C and its derivatives (I'm not very familiar with languages before C) are statically typed (not strongly typed). We were squeezing performance out of the machine, and allocating 8 bytes to every variable so that it could be a double if it felt like it was not the way to do it.

Then dynamically typed languages that were aimed at lower performance scripting and a higher rate of development came about (like Python and Ruby). Dynamically typed languages let you assign variables to different types because the variables are all reference types (so the computer only needs space for a memory address). You didn't need to worry about types, you could just *code* as fast as you wanted and make things just work.

If you build a moderately large codebase in one of these languages, you might notice that things start to get hard pretty quickly. The lack of types can lead to many runtime errors. Now we have TypeScript and Python type annotations, so we can do some static type checking before running our programs to eliminate runtime errors just like you would with Java.

But even with static type checking (which I mostly use when I make changes to a function signature), types are *very useful*. 

Types are more for developers than the computer (following the trend of developer time being more valuable than computer time), and I want to explain one significant instance where this is true.

Like I said before, functions are a level of abstraction. They package up a series of operations. Every programmer knows this. Functional programming is built around this abstraction. 

You want to be able to use a function without knowing how it works inside. That's the whole idea of an abstraction in programming: you hide the hard, messy concept behind something easier, like a function. In C, this sort of thing is easy. You have both `typedef`, which gives you names for types, even if they're just basic types like `int` or `char`. You also have function signatures. In theory, a function name, return type, parameter names and parameter types are enough to use a function. You don't need to understand the internal implementation to use the function.

In dynamically typed languages, like Python, JavaScript, or Ruby, you don't get the function return type or parameter types. This makes it difficult to use functions, both library and your own functions without looking them up. If you can't use functions you wrote without remembering the implementation, how much time are functions saving you?

Types are an abstraction that helps you use your own code more effectively. Take advantage of this.

Please [email me](mailto:samuel.robert.stevens@gmail.com) if you have any comments or want to discuss further.