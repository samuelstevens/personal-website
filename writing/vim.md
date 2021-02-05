---
title: Vim
author:
  - Sam Stevens
keywords:
  [
    vim,
    editor,
    shortcuts,
    vscode,
  ]
abstract: Everyone has a Vim article. This is mine.
---

# Vim

It had to happen.
Nobody writes a blog with a focus on software development and never writes a post on Vim.
This is my Vim story.

## The History

I'd read the stories about Vim for years. 

> "It will change the way you write code"

> "You'll never go back to your old editor"

As a good little software engineering student who spent time on Hacker News and Reddit, I had tried Vim.
Probably three or four times before this time.
I could never get it to stick.

Instead, I started with [BBEdit](https://www.barebones.com/products/bbedit/index.html) at the recommendation of my AP CS teacher.

Then [Atom](https://atom.io/), where I discovered the power of keyboard shortcuts and plugins. 
I used Atom for everything, but it eventually slowed down (Electron apps, amirite?) and I got rid of most of my plugins.

Then my friends who interned at Microsoft told me about [VS Code](https://code.visualstudio.com/).
VS Code is, in my opinion, a *good* editor. 
It is faster than Atom, the built-support for TypeScript is actually crazy (I don't even bother with TypeScript, I just add JSDoc comments to my vanilla JS and let VS Code handle the type errors), the built-in support for HTML/CSS is amazing (links straight to MDN in the tool tips? Font stacks that start with `apple-system` so I don't have to look it up every time? Too good) and it supports plugins well.
At one point, with MyPy and Jedi, my Python dev environment was like using Visual Studio or Eclipse. 
I could go to definitions, see all references, debug step-by-step, all without needing a full-blown IDE.

I even tried PyCharm and decided to stick with VS Code.

I downloaded [Sublime Text](https://www.sublimetext.com/) after reading a great post from [Tristan Hume](https://thume.ca/2017/03/04/my-text-editor-journey-vim-spacemacs-atom-and-sublime-text/) but only used it for large files.

Then MIT's [Missing Semester of CS](https://missing.csail.mit.edu/) video course on [editors](https://missing.csail.mit.edu/2020/editors/) finally convinced me to try Vim again with the promise that I would be back to my previous editor's speed within 20 hours.
I figured that was a week at three hours a day, which seemed pretty reasonable.
Sure enough, a week later of development hell, I was up to speed.
A week later, and I missed Vim keybindings in Google Docs and `<textarea/>`s while applying to grad school.

I also followed the MIT course's advice on dotfiles: `tmux` is an *amazing* tool that will get its own post, [Alacritty](https://github.com/alacritty/alacritty) is a fantastic terminal emulator (even without a GPU), and you should put your dotfiles in a [git repo](https://github.com/samuelstevens/dotfiles) somewhere to make your life easier.

I think the biggest things for Vim are

- the 20 hour hurdle
- the different plugin managers (for what it's worth, I like [vim-plug](https://github.com/junegunn/vim-plug))
- not knowing the words to explain to your search engine what you want (commands? normal mode? `ex:`?)

But overall, Vim is cool.
Very, very cool.
My favorite shortcuts so far:

- `ciw`: change the word your cursor is in (`change` `in` `word`).
- `zz`: make the current line the middle of the screen. 
- [Easymotion](https://github.com/easymotion/vim-easymotion) is a great plug in. 10/10 recommend.

Good luck out there!
