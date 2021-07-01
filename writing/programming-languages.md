---
title: Programming Languages
author:
    - Sam Stevens
keywords: [languages, programming languages, go, typescript, python, javascript, java, lisp, haskell, c, elm, erlang, rust]
abstract: Why I can't decide whether to learn more languages.
---

# Programming Languages



*Alternatively, am I a [Blub](http://www.paulgraham.com/avg.html) programmer?*

I've been reading about programming languages a lot. 
For a while I thought a new language would solve all of my problems. 
If I just learn Lisp like Paul Graham [says](http://www.paulgraham.com/iflisp.html), I'll never need another language. 
If I just learn Haskell, bugs will disappear. 
If I just learn [Elm](https://elm-lang.org/), web apps will just work. 
And so on. 
Over and over again, I would get halfway through a beginner tutorial, need to write some real code for a problem, and use Python or JavaScript. 

Then I read a lot of articles that said that programming languages and new technology really don't matter: Dan McKinley's [Choose Boring Technology](https://mcfunley.com/choose-boring-technology) is one of the best examples of this. 
So I stopped trying to learn Lisp and Haskell and Elm and focused on old tech that was proven to work in production (Lisp technically is old tech). 

So where does that leave me? With my personal ranking of languages, of course. 

## The List

When considering a new language, where does it fit? 
If it's above everything else in your list, it's probably worth learning. 
Here's my list:

1. [Python 3](#python) - ubiquitous, powerful, huge community, support system and ecosystem.

2. [Elm](#elm) - strongly typed, purely functional, exclusively designed for web apps.

3. [Rust](#rust) - statically typed, memory safety without a garbage collector, has a reputation as being difficult to use.

4. [Go](#go) - strongly typed, garbage collector, cooler than Java, minimal syntax to learn.

5. [TypeScript](#typescript) - strongly typed, works for web apps, easy to pick up if you understand JavaScript.

6. [C](#c) - having to think about every line forces efficient code.

7. [JavaScript](#javascript) - amazing package options, enormous ecosystem, functional programming concepts. 

8. [Java](#java) - it works everywhere.

9. [C++](c++) - it's fast, I guess?

> Everything below Rust (#3), I don't ever use unless I have to. I use Python in place of Go or Java, Elm in place of TypeScript or JavaScript, and Rust in place of C or C++.
> Basically, the rankings below Rust are irrelevant.

# Languages I use for new projects

Python, Elm and Rust are the default language I choose for general programming, web apps and high-performance computing, respectively.
Unless there is a goal besides "solve problems and move on," or there's a compelling reason to use a different language, I choose Python, Elm and Rust everytime.

## 1. Python 3

Python was technically a scripting language. 
Technically.
The only problem is that scripts tend to grow until they're unmaintainable (case in point: the bash scripts I use to build this website are getting pretty bad).
Python sort of did the same thing and grew, except it turned into a fantastic general-purpose server-side language for scripting, data analysis, scientific computing, web applications, and algorithm interviews.
Python's success is arguably because of its fantastic front-end design (syntax, general semantics), the simple C FFI, and the monolith of a standard library ([heapq](https://docs.python.org/3.9/library/heapq.html#module-heapq), [bisect](https://docs.python.org/3.9/library/bisect.html#module-bisect) and [shlex](https://docs.python.org/3.9/library/shlex.html#module-shlex) are some of favorite unknown but highly useful modules *in the standard library*).
The C FFI helped the scientific computing ecosystem grow, and packages like [NumPy](https://numpy.org/) and [Jupyter](https://jupyter.org/) make Python a daily driver for all of my research work.

Past the scientific computing, Python's tooling is also pretty good: 

1. [MyPy](https://mypy.readthedocs.io/en/stable/index.html) and the [`typing` module](https://docs.python.org/3/library/typing.html) turn Python into a pretty nice statically-typed language. Use `--strict`.
2. Virtual environments work well, especially with `pyenv` to handle versions of Python. I use a [small function](https://github.com/samuelstevens/dotfiles/blob/main/bashrc#L55-L72) to handle making and activating virtual environments.
3. [Black](https://github.com/psf/black) is a great code formatter. Fast, opinionated, hardly any set-up.
4. [`isort`](https://pycqa.github.io/isort/) sorts your imports. Also fast and very useful.
4. [Flake8](https://flake8.pycqa.org/en/latest/) is a nice linter for unused imports (and other stuff that I'm comletely forgetting about).

When you run into performance issues, it's [pretty](https://samuelstevens.me/writing/optimizing-python-code-with-ctypes) [easy](https://github.com/PyO3/maturin) to rewrite your slow function in a compiled language and efficiently call it from Python.

> I'm going to write an updated version of my [ctypes](https://samuelstevens.me/writing/optimizing-python-code-with-ctypes) guide for Rust soon. Rust is awesome!

Overall, Python is a great blend of simplicity, power, and flexibility. 
The syntax is very simple, functional programming is [well supported](/writing/lisp#emphasis-on-functional-programming), the FFI makes it easy to write highly-optimized code and MyPy gives me more confidence in refactoring.
Really solid stuff.

## 2. Elm

[Elm](https://elm-lang.org/) is a purely functional language with goals of no runtime errors, helpful compiler messages, and a powerful type system. 
It takes some time to shift into a functional mindset, but I've used Elm for several weekend projects that spun into week-long projects, and the compiler was a huge help. 
Coming back to these projects a month later, I found it much, much easier to refactor code, despite forgetting everything that I had written, because the compiler had my back. 
JSON decoding is hard and I don't really understand it, but everything else was slick. 

I also loved not worrying about Webpack and Bable and JSX and TypeScript and what-have-you because `elm make` just works. 
Really nice, I strongly recommend trying it out over a weekend. 
The community is definitely small---I had to write a [CSV parsing package](https://github.com/samuelstevens/elm-csv).
But Elm works so well that it was fun to write a CSV parsing package.
You read that correctly: I thought it was *fun*.

I think any web app that I work on that's not doing some crazy stuff with animations or the Canvas or some brand new web tech will be written in Elm.
It's how I wrote my [Quiet HN clone](https://samuelstevens.me/elm-quiet-hn/).
It's really good at making scalable single-page web apps.

## 3. Rust

[I recently used](https://github.com/samuelstevens/merge-attention) Rust to speed up some Python code using [Maturin](https://github.com/PyO3/maturin).
Learning Rust as a just-in-time operation (time to learn enough about lifetimes to satisfy `rustc`) was a good way for me to learn and led to a very, very useful package.
I rarely work on projects where performance is critical throughout the application---normally there are easily identifiable "hot-spots" that I notice with a profiler.
Those projects are normally Python projects, and Rust and Maturing makes it really simple to speed up hot spots until performance is at an acceptable level.
I used to use C for this sort of thing with [`ctypes`](https://docs.python.org/3.9/library/ctypes.html#module-ctypes), but the Rust compiler gives me confidence in memory usage, the Rust tooling is much better, and the Rust standard library and crate ecosystem are great.

# Other languages I'm familiar with but avoid

These are other languages that I have used for projects in the past, and would feel comfortable working with, but don't use unless there is a good reason to (typically existing code is written in the language).

## 4. Go

[Go](https://golang.org/) is cool. 
The language itself is quite simple, without a lot of extra syntax to learn.
It's strongly typed, which I've realized is very important for writing [readable, maintainable code](/writing/abstractions-and-types). 
It has a garbage collector, so I can write code without having to think about memory all the time. 
It has an autoformatter, the compiler is aggressive in not letting me compile until I have higher quality code (can't compile with an unused variable). 
Basically, Go is great for working on large teams.
Unfortunately, I don't do a lot of team projects where we are writing a server-side application and maintaining the application is absolutely critical.
I think Go would have been a good fit for [TicketBay](https://salty.software/ticketbay).

**Update June 3, 2020**

After building [`img-alter`](/projects/img-alter) in Go, I think Go is almost *too general* a language. 
If I want to make a webapp, I'd use static HTML with Typescript/React. 
If I wanted to make a mobile app, I'd use Typescript/React Native. 
If I wanted to do some data analysis, I'd use Python. 
If I wanted to do real low-level work (for fun, I guess?), I'd use C. 

## 5. TypeScript

[TypeScript](https://www.typescriptlang.org/) is a typed superset of JavaScript that compiles to plain JavaScript. 
Basically, you add types to JavaScript so everyone knows what's going on, and so you remove `"TypeError: Cannot read property 'greeting' of undefined"` errors right off the bat. 

In addition to helping with type errors, TypeScript is amazingly well-integrated with [VS Code](https://code.visualstudio.com/), which is a text editor built on Electron that manages to perform well and provide pseudo-IDE features that never feel overbearing. 

If you use VS Code already with JavaScript, give TypeScript a shot. 
It's amazing how much of the code just falls in place without me reading any API docs. 

Anytime I start a project in JavaScript that's non-trivial, I always start in TypeScript. 
It's just that good.

## 6. C

C is fun for me as a web apps guy because I understand what every line is doing on a much lower level. 
It's very easy to reason about what is happening on the machine, in a not-so-abstract realization. 
Compared to JavaScript, I could tell you what every line is doing in terms of the heap and stack. 
Sometimes that's really fun. 
Other times I need to get work done and C isn't the solution. 
When it is, or when I have to use it for school, I like it.

## 7. JavaScript

JavaScript lets you write code that runs in the browser. 
There are other options (TypeScript, ClojureScript, WebAssembly), but for the most part, you're just writing JavaScript. 

Yeah it sucks. 
Yeah nothing makes sense. 
But ESLint and npm go the distance when you have no other alternatives, and there are thousands of tutorials and resources out there. 

**Update April 21, 2020**

Since going through another Hackathon and building [Slow YouTube](https://github.com/samuelstevens/slow-youtube) using TypeScript, I now firmly believe that JavaScript shouldn't be used in any scenario where it's possible to use any other language.

## 8. Java

Java works everywhere. 
Everyone I know can read and write some Java. 
It's strongly typed, compiled, not that slow now that the JVM is optimized, yadda yadda. 

It's a shame I have only memories of writing shitty Java for early software classes, because I never want to do that again. 

It's Java. 
I can fumble my way through it.

## 9. C++

I worked on [Power BI](https://powerbi.microsoft.com/en-us/) engine at Microsoft.
It's a 100-million+ line C++ project.
I don't claim to be a C++ expert (does anyone?), but I have worked at it enough to form a nascent opinion.

It's really really complicated, but those compiled binaries are really fast.
That is all. 

More seriously, before starting a new project in C++, consider if you could write most of it in C#/Java/Go/Python/something easy and just write the slow parts in C++.
Also consider Rust.

# Languages I'm Missing That I Wish I Wasn't

- Lisp: I keep hearing that Lisp is the one true way. I just couldn't figure it out fast enough to be useful. **Update Feb 5, 2021: [I'm working on fixing this](/writing/lisp).**
- Haskell: apparently a cool language that you don't need to know entirely to be useful, but I don't think I write complicated enough systems to need Haskell. Would it help me with smaller systems?
- Erlang/Elixir: writing extremely fault-tolerant concurrent systems sounds really cool, but I have no need for one. 
- Ruby: also apparently really easy to learn, but I have Python and JavaScript. Where does Ruby fit in?

You'll notice that most of the time I think I don't need any of these languages because I don't have large enough problems to make it worth it. *That scares me*, because I bet people who write in those languages can't imagine a small enough project for it not to be worth using, i.e., I should just learn those languages and use them for everything already.

\*terror that I'm an average programmer increases\*

# Updates

**Update January 5, 2021**

Worked with C++, Rust and Racket.
Worked more with Elm and Python.

**Update Jun 3, 2020**

After spending more time with Go, it feels too general. 

**Update January 21, 2020**

Added Rust.

Please [email me](mailto:samuel.robert.stevens@gmail.com) if you have any comments or want to discuss further..
