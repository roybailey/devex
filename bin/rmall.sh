#!/bin/bash

echo "This utility will force delete all folders/files in pwd and all sub-folders"
echo "the following menu provides some common types for quick selection, or provide your own as an argument"
echo "once seleted the folders/files to be removed will first be listed before a confirmation key to actually force remove them"

MODE=("TARGET" "NODE"         "BUILD" "IDEA"  "GIT" "MAC"       "CUSTOM")
MENU=("target" "node_modules" "build" "idea" ".git" ".DS_Store" "$1")

show_menu() {
  normal=$(echo "\033[m")
  number=$(echo "\033[36m") #Blue
  menu=$(echo "\033[33m")   #yellow
  bgred=$(echo "\033[41m")
  fgred=$(echo "\033[31m")
  printf "\n----------------------------------------\n"
  for ((idx = 1; idx <= ${#MENU[@]}; idx++)); do
    if [ "${MENU[$idx - 1]}" != "" ]; then
      printf "${number} $idx)${menu} ${MENU[$idx - 1]} ${normal} files and folders \n"
    fi
  done
  printf " ${fgred}x) to exit script ${normal}"
  printf "\n----------------------------------------\n"
  printf "Please enter a menu option and enter\n"
  read -r opt
  if [[ "$opt" == "x" ]] || [[ "$opt" == "X" ]]; then
    OPT="EXIT"
  else
    OPT="${MODE[$opt - 1]}"
  fi
}

function removeAll() {
  echo -e "searching all '$1' folders/files"
  find . -name "$1" -depth
  read -p "Press enter to delete the above"
  find . -name "$1" -depth -exec rm -rf {} \;
}

while [ "$OPT" != "EXIT" ]; do
  show_menu "$@"
  echo "you chose ${opt} ${OPT}"
  case $OPT in
  "TARGET")
    removeAll "target"
    ;;
  "NODE")
    removeAll "node_modules"
    ;;
  "BUILD")
    removeAll "build"
    ;;
  "IDEA")
    removeAll "*.iml"
    removeAll ".idea"
    ;;
  "GIT")
    removeAll ".git"
    ;;
  "MAC")
    removeAll ".DS_Store"
    ;;
  "CUSTOM")
    removeAll "$1"
    ;;
  *)
    echo -e "Nothing to do"
    ;;
  esac
done
