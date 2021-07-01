---
title: Why use Lisp in 2021?
author:
  - Sam Stevens
keywords: [ lisp, programming languages, racket ]
build: "pandoc --from markdown+backtick_code_blocks+link_attributes --to pdf writing/lisp.md --out lisp.pdf"
abstract: "Why should I use Lisp? What killer feature of Lisp is missing from Python? How can I learn to use these features in a suitable manner?"
---

# Why Lisp?

This is live documentation of my efforts to understand why I would use Lisp (any Lisp) in 2021. I understand [why it was used extensively in previous decades](http://www.paulgraham.com/diff.html); it had features that no other languages even claimed to have, much less support as robustly as Lisp.
But I don't understand why I would use Lisp nowadays.
Despite this, [lots](https://beautifulracket.com/appendix/why-racket-why-lisp.html) [of](https://medium.com/better-programming/why-i-still-lisp-and-you-should-too-18a2ae36bd8) [people](https://www.grammarly.com/blog/engineering/running-lisp-in-production/) use Lisp as a day-to-day programming language to get things done.
Given that I will be responsible for huge chunks of projects for the next several years and not [limited by a non-technical manager](http://www.paulgraham.com/icad.html), I think it would behoove me to understand both sides of the argument.[^competent]
These are my notes.

[^competent]: [As Mill said](https://en.wikipedia.org/wiki/John_Stuart_Mill#Higher_and_lower_pleasures) [emphasis mine], "It is better to be a human being dissatisfied than a pig satisfied; better to be Socrates dissatisfied than a fool satisfied. And if the fool, or the pig, is of a different opinion, it is because they only know their own side of the question. *The other party to the comparison knows both sides*." I also went and learned how to use [Vim](/writing/vim) for the bazillionth time and it finally stuck. I can't imagine writing *anything* in editors without Vim support now. Maybe it's the same for Lisp?

## Table of Contents

1. [Why Lisp?](#why-lisp)
2. [Motivation](#motivation)
3. [Related Work](#related-work---who-advocates-for-lisp)
4. [Methodology](#methodology---which-features-will-i-learn)
5. [Results](#results---how-did-i-learn-lisp)

## Motivation

I am fully aware (and terrified of) Paul Graham's [Blub Paradox](http://www.paulgraham.com/avg.html): I don't know what my programming language of choice (Blub) is missing, so *I can't miss it.*
Since reading Graham's essay, I've noticed this happen at least four times in recent memory: 

1. [Generator expressions in Python](https://docs.python.org/3.9/reference/expressions.html#generator-expressions) for lazy evaluation.
2. Using `site:<sitename.com>` in web searches.
3. Vim (it's awesome)
4. [tmux](https://github.com/tmux/tmux) (also awesome)
4. [Dash](https://kapeli.com/dash) (and I've only been using it for 3 days)

I can't imagine going back to not using these tools.
But I was doing "fine" before learning them.
To me, that implies that there are other tools/language features that I could not imagine working without, **if I only knew them.**
Not knowing "can't-live-without" features seems like I am deliberately hampering my programming ability.
In an effort to alleviate that, I want to learn Lisp.

Specifically, I want to enumerate the features in Lisp that I'm missing and write enough Lisp to understand the value and power of those specific features.[^other-languages]

> Throughout this document, I'll refer to these features as *Blub++ features*: features that Blub doesn't have, but that Blub++ would.

[^other-languages]: Of course, I'll probably end up wanting to do this in other languages like Haskell or another Hindley–Milner type system language like OCaML. 
Are there other big language features that I haven't encountered, but that users can't live without?

## Related Work - Who Advocates for Lisp?

Eric Raymond's [How to Become a Hacker](http://www.catb.org/~esr/faqs/hacker-howto.html) is widely quoted [emphasis mine]: "Lisp is worth learning for a different reason — the profound enlightenment experience you will have when you finally get it. *That experience will make you a better programmer for the rest of your days*, even if you never actually use Lisp itself a lot." 
[Greenspun's Tenth Rule](https://en.wikipedia.org/wiki/Greenspun%27s_tenth_rule), "Any sufficiently complicated C or Fortran program contains an ad hoc, informally-specified, bug-ridden, slow implementation of half of Common Lisp," leads one to believe that most big programs end up using Lisp-like features anyways, so why not start with Lisp?
Matthew Butterick tries to alleviate some of these issues in [Why Racket? Why Lisp?](https://beautifulracket.com/appendix/why-racket-why-lisp.html).
Anurag Mendhekar [explains](https://medium.com/better-programming/why-i-still-lisp-and-you-should-too-18a2ae36bd8) that he uses Lisp because it is "an s-expression based, dynamically typed, mostly functional, call-by-value lambda-calculus based language."

Paul Graham deserves his own section; his advocacy for Lisp is unparalleled in my internet experience.
Some particular essays of note:
[Revenge of the Nerds](http://www.paulgraham.com/icad.html) makes a fundamental argument that languages are better and worse than each other; that languages can be ranked (in the context of a given problem).
Graham explains the origins of Lisp and explains that Lisp was always designed to be powerful, whereas other languages (Fortran and its descendants) were designed to be fast. 
Both families are converging to powerful *and* fast nowadays.
In 2021, this is an argument both for and against Lisp:

1. Lisp implementations are sufficiently fast, so Lisp is best.
2. Modern languages are powerful, so they are best.

As we'll see later, there are still Lisp features missing from modern languages, so this is probably an arugment for Lisp: you should write Lisp because you are not limited by processing power anymore.
[Succinctness is Power](http://www.paulgraham.com/power.html) is an argument that succinctness is...power (great title).
I agree that succinctness is a good measure of language power. 
I don't agree power is always the most important goal.
Go, Elm and Rust are examples of modern laguages that do not prioritize power above all else.
These languages are powerful because programmers can implement bug-free code faster (in theory).

[Programming Bottom-Up](http://www.paulgraham.com/progbot.html) is an attractive idea to me because I design programs in the top-down manner.
Designing from the bottom up is another *Blub++ feature*: I don't know what this is like, and I can't even imagine how it would change my development process.

## Methodology - Which Features Will I Learn?

Based on my reading, the best features of Lisp are (in no particular order):

- Everything is an expression
- Emphasis on functional programming
- Dynamic typing
- Macros
- Improved development experience as a result of these aspects
- I become a super-genius hacker-man if I write a lot of Lisp???

Also based on my reading, Lisp seems to be best used in applications where (again, no particular order):

- Developer speed is critical.
- You control the execution environment (you're not sending executables to clients).
- You are not working on a large team .[^team]
- Performance is not absolutely critical. [^performance]

[^team]: If you are working on a large team and you don't want to use Java/Python/whatever everyone knows, I think [Go](/writing/programming-languages#go) is best. It's simple to learn and has reasonable performance, excellent tooling, cross-compiles, etc.

[^performance]: If performance is critical in every aspect of your application, then I think [Rust](/writing/programming-languages#rust) is best. Excellent community (lots of packages), excellent tooling, excellent performance. 
If performance is critical only in specific areas, then I think most modern Lisps have a FFI mechanism so you can write the hot spots in Rust/C/Fortran and the rest of the application in Lisp. 
[Python also does this well.](/writing/optimizing-python-code-with-ctypes)
TODO: Check that whatever Lisp I use actually has a nice FFI.

With those criteria in mind, the other languages that I'm quite familiar with that also fit most of these criteria is Python.
Python 3 (henceforth referred to as just Python) has excellent community support, simple syntax, and a [C FFI](/writing/optimizing-python-code-with-ctypes) as a performance escape-hatch. 
MyPy also makes writing correct code much easier in my opinion.

Other languages that I'm **not** familiar with that might fit these criteria:

- Erlang/Elixir
- Ruby
- Haskell/OCaML (I think? There are advocates for Haskell that the type system makes development easier/faster.) TODO: source

To evaluate Lisp against Python, I'll choose features present in Lisp that are not present in Python:

### Everything is an Expression

Python does not treat everything as an expression. 
The classic example to explain the value of "everything is an expression" is presented by Butterick in [Why Racket? Why Lisp?](https://beautifulracket.com/appendix/why-racket-why-lisp.html), and goes something like this:
In Lisp, there are no statements, so any expresssion can be used anywhere.
In Python, you cannot use an if-statement as a value in an assignment expression:

```python

x = if foo:
        2
    else:
        4
```

This is quickly refuted by Python's ternary:

```python
x = 2 if foo else 4
```

Butterick explains that you can do the same thing with operators, which is "impossible" in Python:

```scheme
((if foo * +) 4 3) ; if foo, then 4 * 3, else 4 + 3
```

Arguably you can do this in Python as well (thanks to the power of [immediately invoked function expressions](https://en.wikipedia.org/wiki/Immediately_invoked_function_expression), as I recently learned from [Garrett Morse](https://garrettmorse.com/)), but it is certainly less ergnomic:

```python
((lambda x, y: x * y) if True else (lambda x, y: x + y))(4, 3)
```

(It's almost surprising how much this looks like Lisp.)

It's clunkier in Python than Lisp, but this example is more possible in Lisp because it treats \* and + as functions, whereas infix operators in Python aren't. If instead of \* and + we had `multiply` and `add`, it would be:

```scheme
((if foo multiply add) 4 3)
```

And:

```python
(multiply if foo else add)(4, 3)
```

So while I agree that not everything is an expression in Python, I'm not convinced of its utility.

### Emphasis on Functional Programming

I think Python has a fairly strong lean towards functional programming. 
Functions are first-class objects and can be passed around as values (as shown [above](#everything-is-an-expression)).
[List comprehensions](https://docs.python.org/3.9/tutorial/datastructures.html#list-comprehensions) create copies of lists (emphasizing immutability) and can be used to map and filter lists.
Furthermore, `map` and `filter` are builtins that lazily evaluate the effects of applyin a function to a list.
Reduce is available as [`functools.reduce`](https://docs.python.org/3.9/library/functools.html#functools.reduce), but I definitely use reduce less than map/filter in day-to-day programming.
[Generators](https://docs.python.org/3.9/tutorial/classes.html#generators) allow you to create infinite, lazily-evaluated sequences.

Some missing functional features would be built-in function currying (although it does exist in `functools` under the name of [`partial`](https://docs.python.org/3.9/library/functools.html#functools.partial)) and enforcing side-effect-free (pure) functions.
Other than that, I don't know of any functional programming features that I miss in Python. 
Granted, my only experience with a purely functional language is [Elm](/writing/programming-languages#elm), so I don't know how to use monads or typeclasses (although I think typeclasses are [Hindley–Milner type system](https://en.wikipedia.org/wiki/Hindley%E2%80%93Milner_type_system) feature, not a function language feature).
There are probably functional programming features that I'm not even aware of, simply because they aren't in Python. 
Given that, I belive that functional programming features available in Lisp that I'm not aware of might be worth using Lisp.
  Once I know of such features, however, I'm not convinced that I won't be able to apply that style of thinking to Python.

### Dynamic Typing

Python is dynamically typed. 
[I have found dynamic typing less and less helpful](/writing/abstractions-and-types), but I admit that using `# type: ignore` in some Python code has given me massive flexibility when I need it.
But I don't think Lisp's dynamic typing is going to be somehow life-changing compared to Python.

### Macros

This is the big one.
A quote from [Racket School 2019](https://school.racket-lang.org/2019/plan/mon-mor-lecture.html#(part._.One_.Racket_.Programmer__.Many_.Languages)): "You would write such functions \[macros\] because you want to abstract over recurring patterns in your code that cannot be abstracted over with functions (or other means of conventional abstraction)."
I understand that Python has some [meta-programming capapbilities](https://developer.ibm.com/technologies/analytics/tutorials/ba-metaprogramming-python/), but I don't ever use them, besides decorators in the standard library like [`functools.lru_cache`](https://docs.python.org/3.9/library/functools.html#functools.lru_cache).

Macros are, as far as I can tell, 100% a good reason to use Lisp.

### The Amalgamation of These Features

[Programming Bottom-Up](http://www.paulgraham.com/progbot.html) seems to suggest that all the features of Lisp come together to make development much easier.
It's not any single feature that makes Lisp amazing, but these features in combination.
Chapter 1.5 of [On Lisp](http://www.paulgraham.com/onlisp.html) suggests that "these new possibilities do not stem from a single magical ingredient."
Perhaps Lisp is only a great language because it has all of these features, not any single one.

It is subjective and hard to test, but could be a good reason to use Lisp.

### I become a super-genius hacker-man if I write a lot of Lisp???

This is obviously a subjective reason to use Lisp.
Arguably, writing lots of Python would also make me an excellent programmer, especially if I were to use the more complex features (like meta-programming) on a regular basis.
But my personal experience working in Elm and then returning to Python supports the argument that writing code in a radically different language can improve your programming ability universally.

So maybe learning Lisp for the sake of learning is a good reason to use Lisp.

## Results - How Did I Learn Lisp?

In progress.

### When to use Macros

One initial worry I had when learning Lisp was the idea that I wouldn't know when to use macros.
Whenever I'm introduced to a new abstraction (sum types and pattern matching in Elm, for example), I need to learn when it's appropriate to use it.[^abstractions]
But macros are a whole new class of abstraction; it's like learning that functions exist.
Luckily, Racket School of 2019 has a whole track for macros.
Day 3 is all about macros and starts by explaining "a basic framework for when language extension is appropriate."

> A fundamental aspect of language-oriented programming is identifying these intended abstractions and the invariants that enforce their integrity, then exploiting those invariants to produce a better program than you would have done without the abstraction.

[^abstractions]: Talks like [Make Data Structures](https://www.youtube.com/watch?v=x1FU3e0sT1I) really helped me understand these new tools.

<!-- ## Discussion -->

<!-- ## Conclusion -->

## Arguments Against Lisp

[Joel Spolsky](https://www.joelonsoftware.com/2004/02/27/27-2/): "And I have the ultimate respect for Paul Graham — I think there’s a good probability that in a year or two we will credit him with being the man who solved spam. But I think that if you try to ignore the fact that millions of programmers around the world have learned lisp and don’t prefer to use it, you’re in the land of morbid cognitive dissonance."

<!-- [Eric Raymond](https://www.linuxjournal.com/article/3882)'s "Why Python" is a strong argument for Python (but really only for Python over Perl). -->


## Other Notes

From [Revenge of the Nerds](http://www.paulgraham.com/icad.html):

> "If you can't find ten Lisp hackers, then your company is probably based in the wrong city for developing software."

Maybe I'm in the wrong city, but I don't know anyone who writes *any* Lisp code. 
We wrote a little bit of Scheme at the end of CSE 3345, but nobody I know has continued to use Lisp.

<!-- > "Unlike in other languages, a Racket programmer chooses the programming language for each module in a software base independently of what languages the other components are written in." -->
