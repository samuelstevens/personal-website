---
title: img-alter
author:
  - Sam Stevens
date: June 2020
keywords: [go, golang, accessibility, computer vision, azure, alt tag]
abstract: Uses MS Azure to automatically give all `<img\>` tags in html files an alt attribute.
---

# img-alter

`img-alter` is a program to use MS Azure's computer vision API to automatically create an `alt` attribute for all `<img/>` tags in `html` documents.

[GitHub](https://github.com/samuelstevens/img-alter)

## Development

I'd wanted to do another project in [go](https://golang.org/) after doing a [simple cli project](https://eryb.space/2020/05/27/diving-into-go-by-building-a-cli-application.html). After finding [this piece of advice](https://prog21.dadgum.com/80.html), I started thinking about the stuff I like doing on my computer, and this website was at the front. So I looked at little things I could add, and `alt` attributes was at the front.

