#!/bin/zsh

args=("$@")
arg_1="${args[1]}"
arg_2="${args[2]}"
arg_3="${args[3]}"
arg_4="${args[4]}"

## Base Methods ##

add() {
  git worktree add "${args/add /}"
}

list() {
  git worktree list
}

remove() {
  echo "Removing worktree ${arg_2}"
  git worktree remove "${arg_2}"
}

move() {
  git worktree move "${arg_2} ${arg_3}"
}

## Additional stuff ##

switch() {
  if [[ (-z "${arg_2}") || ("${arg_2}" = "-") ]]; then
    main_tree=$(git worktree list --porcelain | awk '{print $0; exit}')
    main_dir="${main_tree/worktree /}"
    echo "Changing to worktree at: ${main_dir}"
    cd "${main_dir}"
    return
  fi

  tree=$(git worktree list --porcelain | awk '/'"${arg_2}"'/ {print; exit}')
  dir="${tree/worktree /}"
  echo "Changing to worktree at: ${dir}"
	cd "${dir}"
}

help_menu() {
  echo "${directory}"
  echo "Todo: help menu"
}

## Main ##

main() {
  if [[
    (-z "${args}") || 
    ("${arg_1}" = "-h") || 
    ("${arg_1}" = "help") || 
    ("${arg_1}" = "--help") 
  ]]; then
    help_menu
    return;
  fi

  if [[ ("${arg_1}" = "list") || ("${arg_1}" = "-l") ]]; then
    list
  elif [[ ("${arg_1}" = "add") || ("${arg_1}" = "-a") ]]; then
    add
  elif [[ ("${arg_1}" = "switch") || ("${arg_1}" = "-s") ]]; then
    switch
  elif [[ ("${arg_1}" = "remove") || ("${arg_1}" = "-r") ]]; then
    remove
  elif [[ ("${arg_1}" = "move") || ("${arg_1}" = "-m") ]]; then
    move
  fi

}

main
