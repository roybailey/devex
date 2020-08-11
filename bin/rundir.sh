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

if [ "$1" = "" ]; then
  echo "you need to pass in some arguments of what you want to run in all sub-folders"
else
  CMD="$@"
  runCommand "$CMD"
fi


