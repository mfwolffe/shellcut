#!/bin/bash

usage() {
  cat <<EOF
  Usage: shellcut [command] [arguments]

  Commands:
    list    |   list user aliases
    listall |   list all aliases in the current environment

    restore                   | Reset shell config to pre-shellcut state 
    backup [arguments]        | Manage shellcut generated config backups
    remove [alias]            | Attempt to remove an existing (user) alias
    add [alias] [expansion]   | Add a new alias with value <alias> and expansion <expansion>
EOF
}

# @mfwolffe Show alternative to not setting errexit
#
set -o errexit    # abort on failed command
set -o pipefail   # show errors downpipe

# @mfwolffe Mention function declarations look relatively familiar
#
user_alias() {
    cat ~/.zshrc | grep "^alias" | awk -F ' ' '{print $2}'
}

# @mfwolffe Mention hidden folders on unix system
#                   what that condition checks for below
if [ ! -d ~/.zshrc-bk ]; then
	mkdir ~/.zshrc-bk
fi

# @mfwolffe Mention function invocations look a touch different
#
if [[ $1 = "list" ]]; then
	user_alias
  exit 0
fi

# @mfwolffe Mention redirection to dev/null
#                   executing a command from within a different shell
#                   `sort` and `uniq`
#                   `cat`, `tail`, `head`, `less`
#                   Consider mentioning use of `tail` for watching log files
#
if [[ $1 = "listall" ]]; then
	user_alias > ./temp.txt
	eval "${SHELL} -ic alias >> temp.txt" &>/dev/null
	sort --uniq --output ./temp.txt temp.txt          # equivalent to: sort temp.txt | uniq
	less temp.txt
  rm temp.txt
	exit 0
fi

# @mfwolffe Mention Some of the weirder variables like $@
#                   How using shift can save headache when tossing args around
#                     e.g., to pass all but the first argument to this new script `add.sh` we shift once
#                           and pass "@" to the new script.
if [[ $1 = "add" ]]; then
    if [[ $# -lt 3 ]]; then 
      usage
		  exit 1
    fi

	shift
	add.sh "$@"
	exit $?
fi

# @mfwolffe Mention symlink and script invocation differences towards end, not here
if [[ $1 = "remove" ]]; then
	if [[ $# -lt 2 ]]; then
		usage
		exit 1
	fi
	
	shift
	remove.sh "$@"
  exit $?
fi

if [[ $1 = "backup" ]]; then
  shift
  backup.sh "$@"
  exit $?
fi

if [[ $1 = "reset" ]]; then
  reset.sh
  exit $?
fi

usage
exit 1
