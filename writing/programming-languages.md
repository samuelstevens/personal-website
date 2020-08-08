---
title: Programming Languages
author:
    - Sam Stevens
keywords: [languages, programming languages, go, typescript, python, javascript, java, lisp, haskell, c, elm, erlang, rust]
abstract: Why I can't decide whether to learn more languages.
---

# Programming Languages

**Update Jun 3, 2020**

After spending more time with Go, it feels too general. [More](#go).

**Update April 21, 2020**

I've worked a lot with Python.

**Update Januuary 21, 2020**

Added Rust.

**Original Post**

*Alternatively, am I a [Blub](http://www.paulgraham.com/avg.html) programmer?*

I've been reading about programming languages a lot. For a while I thought a new language would solve all of my problems. If I just learn Lisp like Paul Graham [says](http://www.paulgraham.com/iflisp.html), I'll never need another language. If I just learn Haskell, everything will work accordingly. If I just learn [elm](https://elm-lang.org/), web apps will just work. And so on. My friends got tired of me saying I was going to learn a new language. I would get halfway through a beginner tutorial, need to write some real code for a problem, and turn back to Python or JavaScript. 

Then I read a lot of articles that said that programming languages and new technology really don't matter: Dan McKinley's [Choose Boring Technology](https://mcfunley.com/choose-boring-technology) is one of the best examples of this. But even looking at languages like Go, where they left features like generics out, I can see that sometimes a language just needs to work well enough to be useful. So I stopped trying to learn Lisp and Haskell and Elm and focused on old tech that was proven to work in production (Lisp technically is old tech). 

So where does that leave me? With my personal ranking of languages, of course. 

Why is this useful? The next time I tell myself that I'm going to learn a language, I'll need to convince myself that it's more important than writing code to real problems in one of these languages I can already use.

## The List

When learning a new language, where does it fit? If it's above everything else in *your* list, it's probably worth learning. 

1. [Go](#go) - strongly typed, garbage collector, cooler than Java, minimal syntax to learn

2. [Python](#python) - ubiquitous, powerful, strong ecosystem

4. [Elm](#elm) - strongly typed, purely functional, designed for web apps

3. [TypeScript](#typescript) - strongly typed, works for web apps, easy to pick up if you understand JavaScript

4. [C](#c) - have to think about every line forces efficient code  

5. [JavaScript](#javascript) - amazing package options, enormous ecosystem, functional programming concepts. 

6. [Java](#java) - it works everywhere.

## 1. Go

[Go](https://golang.org/) is cool. It's one of the languages that isn't taught at my university, making it more appealing it to me for being cool and hip. It's strongly typed, which I've realized is very important for writing [readable, maintainable code](/writing/abstractions-and-types). It has a garbage collector, so I can write code without having to think about memory all the time. It has an autoformatter, the compiler is aggressive in not letting me compile until I have higher quality code (can't compile with an unused variable). It treats errors as values, with no exceptions (technically, there's `panic()`).

It's missing native GUI support, and the packages for making a web app are limited, but for building an API server, or a CLI, it is really powerful and easy to write. I like Go, and am excited to continue writing in it.

**Update June 3, 2020**

After building [`img-alter`](/projects/img-alter) in Go, I think Go is almost *too general* a language. If I want to make a webapp, I'd use static HTML with Typescript/React. If I wanted to make a mobile app, I'd use Typescript/React Native. If I wanted to do some data analysis, I'd use Python. If I wanted to do real low-level work (for fun, I guess?), I'd use C. 

If I was building a large project, something the size of TicketBay (at least), then I would consider Go for the backend. Since so much of Go is included, I feel that using external packages isn't encouraged, and so I build a lot of little primitives myself (`func fileExists(path string) bool`, for example). If I was working on a huge project, the control and ability to build the application logic in a strongly typed language with builtin testing primitives would be very useful. I just don't really do that.

Probably the same reason I don't use Java.

## 2. Python 3

Python is so useful for scripts. So so useful. And then the script has a bigger use case, and you start writing some error handling code, and your old script is now an automated piece in production, and it's OK, because it's Python, and you have `pylint` and `mypy` and virtual environments. Treat Python right, and it will amazingly useful. The only issue is when you don't treat Python right. 

What does treating Python right look like?

1. Using Python 3. [Please](https://pythonclock.org/). It's so useful to not worry about Unicode in Python.

2. Using virtual environments. Since you use Python 3, virtual environments work in one step: `python3 -m venv <virtualenv_name> && . <virtualenv_name>/bin/activate`. Just do it already.

3. Using [type annotations](https://docs.python.org/3/library/typing.html) and `mypy`. This turns Python into a pseudo-strongly typed (mediocrely-typed? sometimes-typed?) language.

4. Using `pylint` on your code. Yes, `pylint` complains about stuff like documentation and unused variables and unnecessary imports. Wait until you've finished the logic and the testing to check pylint. Commit the code before you fix the errors, in case something breaks. But when you defeat pylint, your code is readable and documented. Amazing stuff.

**Update April 21, 2020**

I've used almost exclusively Python in the last 4 months, and learned a lot. Type annotations are pretty good, especially when you use `mypy --strict`. But there are still some things that slip through:

* `@functools.lru_cache()` turns your function into `Any -> Any`, which invalidates existing type annotations.
* Adding type annotations to code you don't own can be difficult; I don't want to have to create type stubs for `tqdm` and `numpy`.

It still seems more useful that TypeScript though, because of Jupyter Notebooks. Granted, a lot of my work is exploratory, data-science stuff that takes advantage of the large Python ecosystem.

## 3. Elm

[Elm](https://elm-lang.org/) is a purely functional language with goals of no runtime errors, helpful compiler messages, and a powerful type system. It takes some time to shift mindsets into a functional over imperative style, but I've used it for several weekend projects that spun into week-long projects, and the compiler was a huge help. Coming back to these projects a month later, I found it much, much easier to refactor code, despite forgetting everything that I had written, because the compiler had my back. JSON decoding is hard and I don't really understand it, but everything else was slick. 

I also loved not worrying about Webpack and Bable and JSX and TypeScript and what-have-you because `elm make` just works. Really nice, I strongly recommend trying it out over a weekend. The community is definitely small--I had to write a CSV parsing package. But it works so well, that it was fun to write a CSV parsing package. *Fun.*

## 4. TypeScript

[TypeScript](https://www.typescriptlang.org/) is a typed superset of JavaScript that compiles to plain JavaScript. Basically, you add types to JavaScript so everyone knows whats going on, and so you remove `"TypeError: Cannot read property 'greeting' of undefined"` errors right off the bat. 

In addition to helping with type errors, TypeScript is amazingly well-integrated with [VS Code](https://code.visualstudio.com/), which is a text editor built on Electron that manages to perform well and provide pseudo-IDE features that never feel overbearing. 

If you use VS Code already with JavaScript, give TypeScript a shot. It's amazing how much of the code just falls in place without me reading any API docs. 

Anytime I start a project in JavaScript that's non-trivial, I always start in TypeScript. It's just that good.

## 5. C

C is fun for me as a web apps guy because I understand what every line is doing on a much lower level. It's very easy to reason about what is happening on the machine, in a not-so-abstract realization. Compared to JavaScript, I could tell you what every line is doing in terms of the heap and stack. Sometimes that's really fun. Other times I need to get work done and C isn't the solution. When it is, or when I have to use it for school, I like it.

## 6. JavaScript

JavaScript lets you write code that runs in the browser. There are other options (TypeScript, ClojureScript, WebAssembly), but for the most part, you're just writing JavaScript. 

Yeah it sucks. Yeah nothing makes sense. But ESLint and npm go the distance when you have no other alternatives, and there are thousands of tutorials and resources out there. 

**Update April 21, 2020**

Since going through another Hackathon and building [Slow YouTube](https://github.com/samuelstevens/slow-youtube) using TypeScript, I now firmly believe that JavaScript shouldn't be used in any scenario where it's possible to use any other language.

## 7. Java

Java works everywhere. Everyone I know can read and write some Java. It's strongly typed, compiled, not that slow now that the JVM is optimized, yadda yadda. 

It's a shame I have only memories of writing shitty Java for early software classes, because I never want to do that again. 

But it's on my resume, cause, you know. It's Java. I can fumble my way through it.

## Languages I'm Missing That I Wish I Wasn't

* Lisp: I keep hearing that Lisp is the one true way. I just couldn't figure it out fast enough to be useful.

* Haskell: apparently a cool language that you don't need to know entirely to be useful, but I don't think I write complicated enough systems to need Haskell. Would it help me with smaller systems?

* Erlang/Elixir: writing extremely fault-tolerant concurrent systems sounds really cool, but I have no need for one. 

* Ruby: also apparently really easy to learn, but I have Python and JavaScript. Where does Ruby fit in?

**Update Januuary 21, 2020**

* Rust: type checking, imperative, memory safe, compiled, helpful compiler...seems like Go but without channels and a GC. It might be worth checking out for more performance based problems. If I could interface with it through Python, I think it would completely replace my use of C. 

You'll notice that most of the time I think I don't need any of these languages because I don't have large enough problems to make it worth it. *That scares me*, because I bet people who write in those languages can't imagine a small enough project for it not to be worth using, i.e., I should just learn those languages and use them for everything already.

\*terror that I'm an average programmer increases\*

Please [email me](mailto:samuel.robert.stevens@gmail.com) if you have any comments or want to discuss further..