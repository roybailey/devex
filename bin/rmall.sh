#!/bin/bash

echo "This utility will force delete all folders/files in pwd and all sub-folders"
echo "the following FG_OPTION provides some common types for quick selection, or provide your own as an argument"
echo "once seleted the folders/files to be removed will first be listed before a confirmation key to actually force remove them"

FG_NORMAL=$(echo "\033[m")
FG_INDEX=$(echo "\033[36m") #Blue
FG_OPTION=$(echo "\033[33m")   #yellow
BG_RED=$(echo "\033[41m")
FG_RED=$(echo "\033[31m")

MODE=("TARGET" "NODE" "BUILD" "IDEA" "GIT" "MAC" "CUSTOM")
MENU=("target" "node_modules" "build" "idea" ".git" ".DS_Store" "$1")

show_FG_OPTION() {
  printf "\n----------------------------------------\n"
  for ((idx = 1; idx <= ${#MENU[@]}; idx++)); do
    if [ "${MENU[$idx - 1]}" != "" ]; then
      printf "${FG_INDEX} $idx)${FG_OPTION} ${MENU[$idx - 1]} ${FG_NORMAL} files and folders \n"
    fi
  done
  printf " ${FG_RED}x) to exit script ${FG_NORMAL}"
  printf "\n----------------------------------------\n"
  printf "Please enter an ${FG_INDEX} option number ${FG_NORMAL} and hit enter\n"
  read -r opt
  case $opt in
  "x" | "X" | "q" | "Q")
    OPT="EXIT"
    ;;
  *)
    OPT="${MODE[$opt - 1]}"
    ;;
  esac
}

function removeAll() {
  for spec in "$@"; do
    echo -e "searching all '$spec' folders/files"
    printf "${FG_RED}"
    find . -name "$spec" -depth
    printf "${FG_NORMAL}"
  done
  read -p "Press enter to delete the above"
  for spec in "$@"; do
    echo -e "${BG_RED}removing all '$spec' folders/files${FG_NORMAL}"
    find . -name "$spec" -depth -exec rm -rf {} \;
  done
}

while [ "$OPT" != "EXIT" ]; do
  show_FG_OPTION "$@"
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
    removeAll "*.iml" ".idea"
    ;;
  "GIT")
    removeAll ".git" ".github"
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
