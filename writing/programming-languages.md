---
title: Programming Languages
author:
    - Sam Stevens
keywords: [languages, programming languages, go, typescript, python, javascript, java, lisp, haskell, c, elm, erlang]
abstract: Why I can't decide whether to learn more languages.
---

# Programming Languages

Alternatively, *am I a [Blub](http://www.paulgraham.com/avg.html) programmer*?

I've been reading about programming languages a lot. For a while I thought a new language would solve all of my problems. If I just learn Lisp like Paul Graham [says](http://www.paulgraham.com/iflisp.html), I'll never need another language. If I just learn Haskell, everything will work accordingly. If I just learn [elm](https://elm-lang.org/), web apps will just work. And so on. My friends got tired of me saying I was going to learn a new language. I would get halfway through a beginner tutorial, need to write some real code for a problem, and turn back to Python or JavaScript. 

Then I read a lot of articles that said that programming languages and new technology really don't matter: Dan McKinley's [Choose Boring Technology](https://mcfunley.com/choose-boring-technology) is one of the best examples of this. But even looking at languages like Go, where they left features like generics out, I can see that sometimes a language just needs to work well enough to be useful. So I stopped trying to learn Lisp and Haskell and Elm and focused on old tech that was proven to work in production (Lisp technically is old tech). 

So where does that leave me? With my personal ranking of languages, of course. 

Why is this useful? The next time I tell myself that I'm going to learn a language, I'll need to convince myself that it's more important than writing code to real problems in one of these languages I can already use.

## The List

When learning a new language, where does it fit? If it's above everything else in *your* list, it's probably worth learning. 

1. Go - strongly typed, garbage collector, cooler than Java, minimal syntax to learn

2. TypeScript - strongly typed, works for web apps, easy to pick up if you understand JavaScript

3. Python - ubiquitous, powerful, strong ecosystem

4. JavaScript - amazing package options, enormous ecosystem, functional programming concepts. 

5. C - have to think about every line forces efficient code  

6. Java - it works everywhere.

## 1. Go

[Go](https://golang.org/) has been really, really cool so far. It's one of the languages that isn't taught at my university, making it more appealing it me for being cool and hip. It's strongly typed, which I've realized is very important for writing readable, maintainable code. It has a garbage collector, so I can write code without having to think about memory all the time. It has an autoformatter, the compiler is aggressive in not letting me compile until I have really good code (cant compile with an unused variable? c'mon), and the standard library is *thicc*. Like, makes Python seem like it has a mediocre standard library thick. It treats errors as values, with no exceptions.

It's missing native GUI support, and the packages for making a web app are limited, but for building an API server, or a CLI, it is really powerful and easy to write. I like Go, and am excited to continue writing in it.

## 2. TypeScript

[TypeScript](https://www.typescriptlang.org/) is a typed superset of JavaScript that compiles to plain JavaScript. Basically, you add types to JavaScript so everyone knows whats going on, and so you remove `"TypeError: Cannot read property 'greeting' of undefined"` errors right off the bat. 

In addition to helping with type errors, TypeScript is amazingly well-integrated with [VS Code](https://code.visualstudio.com/), which is a text editor built on Electron that manages to perform well and provide pseudo-IDE features that never feel overbearing. 

If you use VS Code already with JavaScript, give TypeScript a shot. It's amazing how much of the code just falls in place without me reading any API docs. 

Anytime I start a project in JavaScript that's non trivial, I always start in TypeScript. It's just that good. 

## 3. Python 3

Python is so useful for scripts. So so useful. And then the script has a bigger use case, and you start writing some error handling code, and your old script is now an automated piece in production, and it's OK, because it's Python, and you have `pylint` and `mypy` and virtual environments. Treat Python right, and it will amazingly useful. The only issue is when you don't treat Python right. 

What does treating Python right look like?

1. Using Python 3. [Please](https://pythonclock.org/). It's so useful to not worry about Unicode in Python.

2. Using virtual environments. Since you use Python 3, virtual environments work in one step: `python3 -m venv <virtualenv_name> && . <virtualenv_name>/bin/activate`. Just do it already.

3. Using [type annotations](https://docs.python.org/3/library/typing.html) and `mypy`. This turns Python into a pseudo-strongly typed (mediocrely-typed? sometimes-typed?) language.

4. Using `pylint` on your code. Yes, `pylint` complains about stuff like documentation and unused variables and unnecessary imports. Wait until you've finished the logic and the testing to check pylint. Commit the code before you fix the errors, in case something breaks. But when you defeat pylint, your code is readable and documented. Amazing stuff.

## 4. JavaScript

JavaScript lets you write code that runs in the browser. There are other options (TypeScript, ClojureScript, WebAssembly), but for the most part, you're just writing JavaScript. 

Yeah it sucks. Yeah nothing makes sense. But ESLint and npm go the distance when you have no other alternatives, and there are thousands of tutorials and resources out there. 

## 5. C

C is fun for me as a web apps guy because I understand what every line is doing on a much lower level. It's very easy to reason about what is happening on the machine, in a not-so-abstract realization. Compared to JavaScript, I could tell you what every line is doing in terms of the heap and stack. Sometimes that's really fun. Other times I need to get work done and C isn't the solution. When it is, or when I have to use it for school, I like it.

## 6. Java

Java works everywhere. Everyone I know can read and write some Java. It's strongly typed, compiled, not that slow now that the JVM is optimized, yadda yadda. 

It's a shame I have only memories of writing shitty Java for early software classes, because I never want to do that again. 

But it's on my resume, cause, you know. It's Java. I can fumble my way through it.

## Languages I'm Missing That I Wish I Wasn't

* Lisp: I keep hearing that Lisp is the one true way. I just couldn't figure it out fast enough to be useful.

* Haskell: apparently a cool language that you don't need to know entirely to be useful, but I don't think I write complicated enough systems to need Haskell. Would it help me with smaller systems?

* Erlang/Elixir: writing extremely fault-tolerant concurrent systems sounds really cool, but I have no need for one. 

* Ruby: also apparently really easy to learn, but I have Python and JavaScript. Where does Ruby fit in?

* Elm: Haskell for web apps. Same reasoning as Haskell, but *for web apps*.

**Update 1/21/2020**

* Rust: type checking, imperative, memory safe, compiled, helpful compiler...seems like Go but without channels and a GC. It might be worth checking out for more performance based problems. If I could interface with it through Python, I think it would completely replace my use of C. 

You'll notice that most of the time I think I don't need any of these languages because I don't have large enough problems to make it worth it. *That scares me*, because I bet people who write in those languages can't imagine a small enough project for it not to be worth using, i.e., I should just learn those languages and use them for everything already.

\*terror that I'm an average programmer increases\*

Please [email me](mailto:samuel.robert.stevens@gmail.com) if you have any comments or want to discuss further..