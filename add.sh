#!/bin/bash

usage() {
  cat <<EOF
  Usage: shellcut add [alias] [expansion] [start|end]

  Examples:
    shellcut add TOM "echo jerry"       | adds new alias to alias block in config
    shellcut add TOM "echo jerry" start | adds new alis to start of alias block in config
EOF
}


# `add` needs at least 2 args. just exit if missing
if [[ $# -lt 2 ]]; then
    printf  "Invalid arguments."
   	exit 1
fi

# @mfwolffe mention hidden folders on unix system
#                   bizarre bash conditional syntax
#                     esp mention [[]] vs [] and builtin vs. invoke test
if [ ! -d ~/.zshrc-bk ]; then
	mkdir ~/.zshrc-bk
fi

# @mfwolffe Show this script
#           Mention symlink stuff later
bkzsh.sh

# below print is the naïve approach to what I want done I suppose
# just write an alias assignment to zsh config 

# @mfwolffe mention   implementation differences BSD vs UNIX vs POSIX vs GNU 
#                     and why using printf is much better than using echo in
#                     most cases
# printf "\nalias ${1}=\"${2}\"\n" >> ~/.zshrc

# now do the thing but place the new alias within
# block dedicated to aliases within config file
# we don't want newlines anymore
ALIASSTR="alias ${1}=\"${2}\""

# @mfwolffe Mention: Pipes
#                    `awk` & `sed`
#                    Reiterate cmd subst
#                    `grep`/regex
#                    Most things can be done many different ways
#
#           Show     That the output w/ diff commands is the same w/ `diff`
#
FIRSTLINE=$(cat ~/.zshrc | grep -n "^alias" | awk -F ':' '{print $1}'| head -n 1)
LASTLINE=$(cat ~/.zshrc | grep -n "^alias" | cut -d ':' -f 1 | tail -n 1)

# @mfwolffe Mention arithmetic be weird 
INSERTLINE=$(($LASTLINE+1))

# @mfwolffe Mention That str comparisons use single '='
if [ "${3}" = "start" ]; then
  INSERTLINE=$FIRSTLINE
fi

# @mfwolffe Mention heredocs
#                   EOF and keybind and how you can "send" an EOF to a thing that's reading something
ex ~/.zshrc << eof
$INSERTLINE insert
$ALIASSTR
.
xit
eof

# @mfwolffe Show orig naïve approach to line insertion
#                version
# TEMP="~/.temprc"

# touch "${TEMP}"
# cat -n "${FIRSTLINE}" ~/.zshrc > "${TEMP}"
# printf "%s" "${ALIASSTR}" >> "${TEMP}"
# tail -n $((    )) ~/.zshrc >> "${TEMP}"
# cat "${TEMP}" > ~/.zshrc
# rm "${TEMP}"

# @mfwolffe Mention That these scripts should end with a newline

