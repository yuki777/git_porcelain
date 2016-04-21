[![Slack Room][slack-badge]][slack-link]
[![Travis][travis-badge]][travis-link]

# Git_porcelain

User-friendly [Git status] output information inspired and adapted from [git-radar].

![git_porcelain]

## Install

With [fisherman]

```
fisher git_porcelain
```

## Usage

Typically you'll store the result in a variable to be output later:

```
set gitporcelain (git_porcelain)
...
printf "blah blah %s" $gitporcelain
```

> git_porcelain comes with colours by default. To disable, use `git_porcelain -C`.

## Legend

### Symbols

Symbol  | Meaning
--------|--------
A       | A file has been Added
D       | A file has been Deleted
M       | A file has been Modified
R       | A file has been Renamed
C       | A file has been Copied
U       | A file is untracked

### Colors

Color   | Meaning
--------|--------
Green   | Staged and ready to be committed (i.e. you have done a `git add`)
Red     | Unstaged, you'll need to `git add` them before you can commit
Grey    | Untracked, these are new files git is unaware of
Yellow  | Conflicted, these need resolved before they can be committed

## Prompts using git_porcelain

1. [jetty]

[Git status]: https://git-scm.com/docs/git-status
[git_porcelain]: http://i.imgur.com/EvA0dNI.png

[slack-link]: https://fisherman-wharf.herokuapp.com/
[slack-badge]: https://img.shields.io/badge/slack-join%20the%20chat-00B9FF.svg?style=flat-square
[travis-badge]: https://travis-ci.org/fisherman/git_porcelain.svg?style=flat-square
[travis-link]: https://travis-ci.org/fisherman/git_porcelain
[fisherman]: https://github.com/fisherman/fisherman
[git-radar]:https://github.com/michaeldfallen/git-radar

[jetty]:https://github.com/jethrokuan/jetty
