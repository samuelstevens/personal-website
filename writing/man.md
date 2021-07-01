---
title: Those Numbers in the Man Pages
author:
    - Sam Stevens
keywords: [man, man pages, number, unix, linux, bash, documentation, numbers]
abstract: Explaing what those numbers on man pages actually mean 
---

# Those Numbers in the Man Pages

Ever seen used `man` and seen output like `PRINTF(3)`, or `TIME(1)`?
I always wondered what they meant.
Here's the answer.

# The number corresponds to the manual section.

From `man man` (on RHEL):

```
1   Executable programs or shell commands
2   System calls (functions provided by the kernel)
3   Library calls (functions within program libraries)
4   Special files (usually found in /dev)
5   File formats and conventions eg /etc/passwd
6   Games
7   Miscellaneous (including macro packages and conventions), e.g. man(7), groff(7)
8   System administration commands (usually only for root)
9   Kernel routines [Non standard]
```

You can check the purpose of each section with `man <NUM> intro`.

You can pick a section when reading the pages:

```sh
man 1 time # explains the time shell command
man 2 time # explain the time syscall
```

On macOS, which is a derivative of BSD, system calls like `time` and `printf` are actually just library calls. 
So `man 1 time` will show the shell command, but `man 2 time` prints `No entry for time in section 2 of the manual`.
`man 3 time` shows the documentation for the `time_t time(time_t *tloc)` function, because it's a standard C library.

On a Red Hat (RHEL) system I have access to, `man 2 time` shows the Linux man pages (as a system call) and `man 3 time` shows the POSIX man pages, explaining that the implementation may differ on Linux compared to the POSIX standard.

You can also see ALL the available man pages for time (in sequence) with `man -a time`, or search for man pages with `man -k <cmd>` (which will also do substring matches).
Here are some examples:

```sh
# 1. Show all printf man pages:
man -k '^printf'

# 2. Show all print commands with man pages
man -k print
```

I still don't know how to specify the end of the string: `'^printf$'` didn't work, like I would have expected.

> Credit: this [question](https://unix.stackexchange.com/questions/3586/what-do-the-numbers-in-a-man-page-mean) helped me understand what the numbers after names in man pages mean.

