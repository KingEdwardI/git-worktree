# Git Worktree Manager

This is a small script wrapper to help with managing git worktrees.

This provides a wrapper around the base commands, and some utility
methods to help with managing the worktrees.
Worktrees are stored at $HOME/.worktrees to avoid cluttering up local directories

## Installation

Todo: a better installation process...

For now, the way I've gotten this to work is a bit convoluted.
So far it's solved most of the issues I've had, but it could be better.

1. If needed, make the script executable:
  - `chmod +x git-worktree.sh`
2. Copy the script into your preferred bin folder.
  - `cp git-worktree.sh /usr/bin/local/gwt`
  - **Note:** This is not required, you can put the script anywhere.
    I just find it convenient to have it in a static location.
3. Add an alias to your .bashrc, .zshrc, etc.
  - `alias gwt=". gwt"`

Now you should be good to go. Open a new shell and test it out by
simply running `gwt`. It should print the help menu.

#### Background/Explanation

I originally wanted to write this in python or another language but
because those programs will run in their respective interpreters,
the `switch` command (the most important one) will not / cannot
change the directory of the shell you are working out of. 

The same effect is true with bash scripts. The script runs in a 
subshell, so no commands / actions are propagated back up to the
shell you are working out of.

So the workaround that I'm using is to `source` the script so
that it runs in the main shell and is able to switch folders there.

## Usage

```
gwt - displays this menu
gwt [-h --help help] - displays this menu
gwt [-l list] - prints a list of worktrees for the current project
gwt [-a add] <worktree-name> - creates a new worktree based on the current working tree
gwt [-s switch] <worktree-name> - switches current worktrees
gwt [-r remove] <worktree-name> - deletes an existing worktree
gwt [-m move] <old-name> <new_name> - moves an existing worktree to a new location
```

## Credit

This is heavily based off of [git-worktree-switcher](https://github.com/yankeexe/git-worktree-switcher). 
I wanted a better general experience, with the `git worktree` commands
built in and consistent usage as far as `gwt <command> <argument>`.
