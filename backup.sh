#!/bin/bash

# Literally just a console format function
# named centering as a nod to LaTeX nuisance
# (only sometimes I guess) of the same name
centering() {
  col=$(tput cols)
  printf "\n%*s\n" $(((${#1}+$col)/2)) "$1"
}

addnamed() {
  pushd "${HOME}/.zshrc-bk/named"
  touch "${1}"
  cat "${HOME}"/.zshrc > "${1}"
  popd 
}

show() {
  touch lsout
  ls "${HOME}/.zshrc-bk" > lsout
  filename=$(cat lsout | head -n "${1}" | tail -n 1)
  cat "${HOME}/.zshrc-bk/${filename}"
  rm lsout
}

# SEEME lol keep it less than 80 columns?
usage() {
  centering ">|< SHELLCUT >|<"
  cat <<EOF
  Usage: shellcut backup [command]

  Commands:
    list              |   List all current backups
    purge             |   Delete all stored backups
    create            |   Create new shell config backup
    show      [n]     |   Write a specific backup to stdout
    restore   [n]     |   Restore config to a specific backup
    showdiff  [n]     |   Diff a specific config with the current config
    addnamed  [name]  |   Create a named shell config backup file with filename
                          [name].bk if no dot-suffix file extension is provided
                          otherwise with filename [name]
EOF
}

# TODO @mfwolffe Make logic a switch

# @mfwolffe Mention getopt and why I am not using it in these scripts
#                     (because there's 3 diff implementations and it's annoying)
if [[ $1 = "list" ]]; then
  ls -1 $HOME/.zshrc-bk/ | cat -b
  exit 0
fi

# @mfwolffe Mention That regex can be used to capture and operate on groups 
#                   Exit codes      
if [[ $1 = "purge" ]]; then 
  rm $HOME/.zshrc-bk/*
  exit 0
fi

# @mfwolffe Mention At the end after symlinking "shellcut" from local bin to here
#                   that we need to remove the './' unless we are here
if [[ $1 = "create" ]]; then
  bkzsh.sh
  exit 0
fi

if [[ $1 = "restore" ]]; then
  shift
  restore.sh "$@"
  exit $?
fi

if [[ $1 = "show"   ]]; then
  if [[ $2 -eq 0 ]]; then
    usage 
    exit 1
  fi

  show "${2}"

  # @mfwolffe Mention Scripts should clean up after themselves
  exit 0
fi

if [[ $1 = "addnamed" ]]; then
  if [[ ! -d "${HOME}/.zshrc-bk/named" ]]; then
    mkdir "${HOME}/.zshrc-bk/named"
  fi

  # we don't want all our files named 'addname.bk'
  shift

  # trust me I know that regex is stupid, it's just 2am
  # and I am not sure why I am intent on working on this
  # rn
  if [[ "${1}" =~ .[a-zA-Z][a-zA-Z]*$ ]]; then
    addnamed "${1}"
    exit 0
  fi

  addnamed "${1}".bk
  exit 0
fi

# @mfwolffe nothing new here other than diff cmd
if [[ $1 = "showdiff" ]]; then
  if [[ $2 -eq 0 ]]; then
    usage
    exit 1
  fi

  show "${2}"
  diff "${HOME}/.zshrc-bk/${filename}" "${HOME}/.zshrc"
  exit 0
fi

usage
exit 1
