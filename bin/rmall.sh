#!/bin/bash

function removeAll() {
  echo -e "removing all '$1' folders/files"
  find . -name "$1" -depth
  read -p "Press enter to delete the above"
  find . -name "$1" -depth -exec rm -rf {} \;
}

echo "This utility will force delete all folders/files in pwd and all sub-folders"
echo "the following menu provides some common types for quick selection, or provide your own as an argument"
echo "once seleted the folders/files to be removed will first be listed before a confirmation key to actually force remove them"
echo

# needs a really long option to force vertical display of menu
options=($1 "'target' folders" "'node_modules' folders" "'build' folders" "idea related files and folders" "'.git' folders" ".DS_Store mac files" "---------- exit this script ----------")
select menu in "${options[@]}";
do
  echo -e "\nyou picked $menu ($REPLY)"
  case $menu in
  target)
    echo -e "removing all target folders"
    removeAll "target"
    ;;
  node)
    echo -e "removing all node_modules folders"
    removeAll "node_modules"
    ;;
  build)
    echo -e "removing all build folders"
    removeAll "build"
    ;;
  idea)
    echo -e "removing all .idea folders and *.iml files"
    removeAll "*.iml"
    removeAll ".idea"
    ;;
  .git)
    echo -e "removing all .git files"
    removeAll ".git"
    ;;
  .DS_Store)
    echo -e "removing all .DS_Store files"
    removeAll ".DS_Store"
    ;;
  *)
    if [ "$1" = "$menu" ]; then
      removeAll "$1"
    else
      echo -e "exiting"
      exit 0
    fi
    ;;
  esac
done
