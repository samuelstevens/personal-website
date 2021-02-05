---
title: Pseudo-elements in CSS
author:
  - Sam Stevens
keywords:
  [
    programming,
    css,
    html,
    pseudo-elements,
    pseudoelements,
    pseudo,
    elements,
    :after,
    ::after,
    guide,
    tutorial,
  ]
abstract: Why pseudo elements aren't that scary!
---

# Pseudo-elements in CSS

Pseudo-elements like `::after` and `::before` used to terrify me. Then I used them once and I thought "time to write a blog post". Given that, there will almost certainly be mistakes or not-best-practices in here. I still want to share what I learned, in case it can help anyone else out.

I'm going to show some CSS to highlight links (_hover over some of the links on this page if you're on desktop to see it_) using the `::after` element, and then **break down how it works**.

## Table of Contents

1. [Complete CSS for links](#complete-css-that-were-going-to-build)
2. [What is `::after`?](#what-in-gods-name-is-after)
3. [`::after` with links](#after-with-links)
4. [Pseudo-elements and pseudo-classes](#pseudo-elements-and-pseudo-classes-oh-my)
5. [Final version (with tweaks)](#final-tweaked-version-used-on-this-page)
6. [Resources](#more-resources)

## Complete CSS That We're Going to Build

```css
a {
  color: #91710a;
  position: relative;
  display: inline-block;
}

a:hover {
  color: white;
}

a::after {
  content: "";
  background-color: #91710a;

  position: absolute;
  bottom: 0px;
  right: 0px;
  left: 0px;

  height: 0%;

  transition: all ease 0.2s;

  z-index: -1;
}

a::after:hover {
  height: 100%;
}
```

## What in God's Name is `::after`?

If you've never seen `::after` before, like me, this might look like some serious [CSS hacking](https://css-tricks.com/the-shapes-of-css/) that is incomprehensible. Let's break it down into something very understandable.

The first thing to know is that [pseudo-elements](https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-elements) are like elements that every HTML tag can have. There are currently 14, but I mostly use 2: `::before` and `::after`. Since they're basically the same tag, I'm going to focus on `::after` in this post.

Pseudo-elements are just selectors for "imaginary" elements that you can insert content into and modify with CSS.

So, for instance, if we wanted to add an smiley face after all of our paragraphs, we would use `::after` and `content` to do that:

```css
p::after {
  content: "😊";
}
```

If we wanted that smiley face to be real big, we could as well:

```css
p::after {
  content: "😊";
  font-size: 3em;
}
```

> (I should've figured a good way for you to turn these styles on and off with some Javascript. Oh well.)

## `::after` with Links

So, going back to highlighting links. We're going to animate the `::after` element on every `<a>` tag when someone hovers over it.

First, we need `<a>` tags to have `position: relative;` and `display: inline-block;` so that we can position our highlight appropriately.

```css
a {
  color: #91710a;
  position: relative;
  display: inline-block;
}
```

Then, we style the highlighted rectangle:

```css
a::after {
  /* we want it to be empty */
  content: "";
  background-color: #91710a;

  /* cover the entire <a> tag */
  position: absolute;
  bottom: 0px;
  top: 0px;
  right: 0px;
  left: 0px;

  /* it still needs to sit behind <a>'s text */
  z-index: -1;
}
```

With that in place, every `<a>` tag is now covered by a block! We only want to show this on hover:

```css
a::after:hover {
  /* nothing changes */
}
```

## Pseudo-Elements and Pseudo-Classes, Oh My!

Just like normal HTML elements, pseudo-elements have pseudo-classes (like `:hover`, `:active`, etc.). This is part of what makes pseudo-elements so powerful. They work just like HTML elements (in most cases).

The final component is animating the growth of the element:

```css
a::after {
  content: "";
  background-color: #91710a;

  position: absolute;
  bottom: 0px;
  /* when not hovered, it shouldn't show */
  height: 0%;

  right: 0px;
  left: 0px;

  /* describing our transition */
  transition: all ease 0.2s;

  z-index: -1;
}

/* make it grow when hovered over */
a::after:hover {
  height: 100%;
}
```

From there, we can adjust some values to make it look a little nicer (seen below).

## Final, Tweaked Version Used on This Page

```css
a {
  color: #91710a;

  position: relative;
  display: inline-block;

  transition: all ease 0.2s;
}

a:hover {
  color: white;
}

a::after {
  content: "";

  background-color: #c59f3f;
  border-radius: 3px;

  position: absolute;
  bottom: 0px;
  right: -2px;
  left: -2px;

  height: 0%;

  transition: all ease 0.2s;

  z-index: -1;
}

a::after:hover {
  height: 95%;
}
```

I hope this helped you understand what pseudo-elements are and how useful they can be!

> I shamelessly took this style of expanding-link highlights from [https://sobolevn.me/](https://sobolevn.me/).

## More Resources

- [MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-elements)
- [Pseudo-elements for CSS shapes](https://css-tricks.com/the-shapes-of-css/)
- [Pseudo-element tricks in general](https://css-tricks.com/pseudo-element-roundup/)

Please [email me](mailto:samuel.robert.stevens@gmail.com) if you have any comments or want to discuss further.

<style>
a {
  position: relative;
  display: inline-block;
  transition: all ease 0.2s;
}

a:hover {
  color: white;
}

a::after {
  content: "";
  background-color: #c59f3f; 
  position: absolute;
  bottom: 0;
  height: 0%;
  right: -2px;
  left: -2px;
  transition: all ease 0.2s;
  z-index: -1;
  border-radius: 3px;
}

a:hover::after {
  height: 95%;
}
</style>
