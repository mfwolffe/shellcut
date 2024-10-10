#1/bin/bash

# all this does is backup the current zshrc

# @mfwolffe Mention all the various substitutions and expansions
#
cat ~/.zshrc > ~/.zshrc-bk/zshrc-$(date +"%Y-%m-%d:%H:%M:%S").bk
