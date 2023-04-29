---
title: Unix
author:
  - Sam Stevens
keywords:
  [
    unix,
    bash,
    zsh,
    tmux,
    editing,
    vim,
    editor,
    shortcuts,
  ]
abstract: Unexpected outcomes of using Vim full-time.
---


Since using [Vim as an editor](/writing/vim) full-time, I have spent a lot more time in a shell over any other environment. I have noticed that I have become much more proficient using bash (actually zsh) to do day-to-day editing tasks. More importantly, becoming more comfortable with bash has opened up more options to me in manipulating my filesystem and editing environment. If I have to rename 100 files based on a pattern, I used to have to write a Python script. Just last week I busted out `for f in $(fd token); do cp $f $(echo $f | sed 's/token/uuid/'); done`

## Examples

```bash
# To put a list of directories to delete on my clipboard
printf '%s\n' *-relics | sort -t - -k 1 -g | tr '\n' ' ' | pbcopy

# to cancel all pending jobs on slurm
jobs | grep PENDING | awk '{ print $1 }' | xargs scancel

# to find how many of each job type I had to run
bat todo-prompt.txt | xargs rg prompt_type | awk -F ':' '{ print $2 }' | sort | uniq -c
```


