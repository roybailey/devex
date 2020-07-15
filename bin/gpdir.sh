#!/bin/zsh

function runCommand() {
    for d in ./*/ ; do
      echo
      echo
      echo "------------------------------------------------------------"
      echo "$d"
      echo "."
      /bin/zsh -c "(cd "$d" && "$@")";
    done
}

runCommand "git pull --ff-only"
