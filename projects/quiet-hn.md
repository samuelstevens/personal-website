---
title: Quiet Hacker News
author:
  - Sam Stevens
date: November 2020
keywords: [Hacker News, Elm]
abstract: A front-end clone of QuietHN written in Elm
---

# Quiet Hacker News

Quiet HN was featured on Hacker News several months ago. It was a website that showed the top 30 links from Hacker News, with no comments. It was supposed to help the site author focus on the story contents, rather than just read the comments. The site was written in Go, and I believe it's now a Gophercise. Whatever the case, the site is no longer up at [quiethn.com](https://quiethn.com).

While talking with some friends, I figured that the app could be done purely client-side since the Hacker News API doesn't require an API key. So I wrote it in Elm to practice the ol' functional programming, and then hosted it with GitHub pages.

[You can visit the website here.](/elm-quiet-hn)

(The original site also had really minimal CSS, just like my remake.)

Honestly, full client-side apps that are hosted for free through my GitHub account is _sweet_. Deploying is easy, they basically never go down (as far as I can tell), and I don't have any server maintenance to do.

Source code is [here](https://github.com/samuelstevens/elm-quiet-hn), but it's not pretty. So it goes, when the compiler prevents you from ever making mistakes.
