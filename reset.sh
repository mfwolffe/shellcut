#!/bin/bash

usage() {
	cat <<EOF
	Usage: shellcut reset

  Restore shell config to original state.
  Equivalent to running:
    shellcut restore 0
EOF
}

restore.sh 0
