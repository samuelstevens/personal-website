---
title: Airpods
author:
  - Sam Stevens
keywords: [swift, applescript, airpods, macos]
abstract: Airpods is a macOS app I developed by wrapping BluetoothConnector in an Applescript.
---

# Airpods

I developed _Airpods_, a macOS app that is a simple wrapper for lapfelix's awesome [BluetoothConnector](https://github.com/lapfelix/BluetoothConnector). If you install _Airpods_, and you use Spotlight Search (like me), then you can go `CMD+SPACE Airp...` and _smash_ `ENTER` to disconnect or connect to your airpods (assuming you only have one pair).

The build process is wildly convoluted and could be fixed with a makefile (I think, I still need to learn how to use makefiles, but I hear amazing things about them. What's the difference between a makefile and a bash script?), but it works and is documented.

I'd like to eventually publish this on the App Store, but I also needed to get this off my plate, and it currently works.

## [Download Here](/Airpods.dmg)

## Code

I added a simple `print` option to BluetoothConnector so that I could use an image of Airpods for the notifications, but other than that, just used the default BluetoothConnnector commands and packaged the binary with my .app/.dmg so that it has no external dependencies.
