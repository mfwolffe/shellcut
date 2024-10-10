#!/bin/bash

# @mfwolffe Really emphasize the implementation differences
#           If I was on my linux machine I would approach this
#           task much differently, and with cosiderably less code

# @mfwolffe Demo it:  ssh to stu
#                     show that BSD equivalent command fails
#                     show that gnu (pretty sure) implementation does not
#
nosed() {
	touch awkout
	awk "NR != $1" ~/.zshrc > awkout
	cat awkout > ~/.zshrc
	rm awkout
}

rmline=$(cat ~/.zshrc | grep -n "^alias $1" | awk -F ":" '{print $1}')

# @mfwolffe Mention the '>&2' and silencing from calling script
if [[ $rmline -eq 0 ]]; then
	printf "The alias %s does not exist.\n" $1 >&2
	exit 1
fi

nosed $rmline
