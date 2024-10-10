#!/bin/bash

usage() {
	cat <<EOF
	Usage: shellcut restore [n]

	Example: Restore shell config to the
	         third most recent version.

	         shellcut restore 3
EOF
}

# @mfwolffe Nothing new really until cond. around line 30

bkdir="$HOME/.zshrc-bk"

if [[ $# -ne 1 ]]; then
	usage
	exit 1
fi

if [[ $1 -eq 0 ]]; then
  if [[ ! -d $HOME/.shellcut ]]; then
    mkdir $HOME/.shellcut
  fi

  if [[ ! -f $HOME/.shellcut/orig-config.txt ]]; then
    touch $HOME/.shellcut/orig-config.txt
    cat ~/.zshrc > $HOME/.shellcut/orig-config.txt
  fi

  exit 0
fi

count=$(ls "${bkdir}" | wc -l)

# @mfwolffe Reiterate oddities of bash conditions - I can use traditional `||` because this
#                     is the bash builtin version of `test`. Using just [] as opposed to [[]]
#                     would lead bash to invoke the non-bulitin `test` command
#
if [[ $1 -lt 1 || $1 -gt $count ]]; then
	usage
	exit 1
fi

touch lsout
ls "${bkdir}/" > lsout
filename=$(cat lsout | head -n "${1}" | tail -n 1)

if [[ $filename = "" ]]; then
	usage
	exit 1
fi

# @mfwolffe Reiterate './' invocation vs without
#
bkzsh.sh
diff --color "${bkdir}/${filename}" ~/.zshrc
cat "${bkdir}/${filename}" > ~/.zshrc
rm "${bkdir}/${filename}"
rm lsout

exit 0
