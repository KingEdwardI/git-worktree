#!/bin/zsh

args=("$@")
arg_1="${args[1]}"
arg_2="${args[2]}"
arg_3="${args[3]}"
arg_4="${args[4]}"

worktree_dir="$HOME/.worktrees/"
## Base Methods ##

add() {
  git worktree add "${worktree_dir}${args/add /}"
}

list() {
  git worktree list
}

remove() {
  echo "Removing worktree ${arg_2}"
  git worktree remove "${worktree_dir}${arg_2}"
}

move() {
  git worktree move "${worktree_dir}${arg_2} ${worktree_dir}${arg_3}"
}

## Additional stuff ##

switch() {
  if [[ (-z "${arg_2}") || ("${arg_2}" = "-") ]]; then
    main_tree=$(git worktree list --porcelain | awk '{print $0; exit}')
    main_dir="${main_tree/worktree /}"
    echo "Changing to main worktree at: ${main_dir}"
    cd "${main_dir}"
    # $SHELL
    return
  fi

  tree=$(git worktree list --porcelain | awk '/'"${arg_2}"'/ {print; exit}')
  dir="${tree/worktree /}"
  echo "Changing to worktree at: ${dir}"
  cd "${dir}"
  # $SHELL
}

help_menu() {
  echo "gwt - a wrapper for git's built-in worktree command."
  echo ""
  echo "This provides a wrapper around the base commands, and some utility"
  echo "methods to help with managing the worktrees."
  echo "Worktrees are stored at \$HOME/.worktrees to avoid cluttering up local directories"
  echo ""
  echo "Usage:"
  echo "  gwt - displays this menu"
  echo "  gwt [-h --help help] - displays this menu"
  echo "  gwt [-l list] - prints a list of worktrees for the current project"
  echo "  gwt [-a add] <worktree-name> - creates a new worktree based on the current working tree"
  echo "  gwt [-s switch] <worktree-name> - switches current worktrees"
  echo "  gwt [-r remove] <worktree-name> - deletes an existing worktree"
  echo "  gwt [-m move] <old-name> <new_name> - moves an existing worktree to a new location"
}

check_for_worktree_dir() {
  if ! [[ (-d "${worktree_dir}")]]; then
    mkdir "${worktree_dir}"
  fi
}

## Main ##

main() {
  echo  "${arg_1}" "${arg_2}" "${arg_3}" "${arg_4}"
  check_for_worktree_dir

  if [[
    (-z "${args}") || 
    ("${arg_1}" = "-h") || 
    ("${arg_1}" = "help") || 
    ("${arg_1}" = "--help") 
  ]]; then
    help_menu
    return;
  fi

  if [[ 
    ("${arg_1}" = "list") || 
    ("${arg_1}" = "-l") 
  ]]; then
    list
  elif [[ 
    ("${arg_1}" = "add") || 
    ("${arg_1}" = "-a") 
  ]]; then
    add
  elif [[ 
    ("${arg_1}" = "switch") || 
    ("${arg_1}" = "-s") 
  ]]; then
    switch
  elif [[ 
    ("${arg_1}" = "remove") || 
    ("${arg_1}" = "-r") || 
    ("${arg_1}" = "rm") 
  ]]; then
    remove
  elif [[ 
    ("${arg_1}" = "move") || 
    ("${arg_1}" = "-m") 
  ]]; then
    move
  fi

}

main
