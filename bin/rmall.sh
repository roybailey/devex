#!/bin/bash

function removeAll() {
  echo -e "removing all '$1' folders/files"
  find . -name "$1" -depth
  read -p "Press enter to delete the above"
  find . -name "$1" -depth -exec rm -rf {} \;
}

options=(idea target node build .DS_Store $1 exit)
select menu in "${options[@]}";
do
  echo -e "\nyou picked $menu ($REPLY)"
  case $menu in
  idea)
    echo -e "removing all .idea folders and *.iml files"
    removeAll "*.iml"
    removeAll ".idea"
    ;;
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
