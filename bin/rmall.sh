#!/bin/bash

options=(idea target node build .DS_Store $1 exit)
select menu in "${options[@]}";
do
  echo -e "\nyou picked $menu ($REPLY)"
  case $menu in
  idea)
    echo -e "removing all .idea folders and *.iml files"
    find . -name '*.iml' -depth -exec rm {} \;
    find . -name '.idea' -depth -exec rm -rf {} \;
    ;;
  target)
    echo -e "removing all target folders"
    find . -name target -depth -exec rm -rf {} \;
    ;;
  node)
    echo -e "removing all node_modules folders"
    find . -name node_modules -depth -exec rm -rf {} \;
    ;;
  build)
    echo -e "removing all build folders"
    find . -name build -depth -exec rm -rf {} \;
    ;;
  .DS_Store)
    echo -e "removing all .DS_Store files"
    find . -name .DS_Store -depth -exec rm {} \;
    ;;
  *)
    if [ "$1" = "$menu" ]; then
      echo -e "removing all '$1' folders/files"
      find . -name '$1' -depth -exec rm {} \;
    else
      echo -e "exiting"
      exit 0
    fi
    ;;
  esac
done
