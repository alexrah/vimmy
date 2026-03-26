#!/bin/bash



if [ "$1" == "help" ] || ( test -z "$1" )
then
  printf "Please provide one of the following option:\n"
  printf "all : remove config and binary\n"
  printf "config: remove only user configuration \n"
  printf "binary: remove nvim binary from /usr/local/bin (requires sudo) \n"
  exit
fi

printf "Removing neovim legacy...\n"
printf "================================\n"

if [ "$1" == "all" ] || ( "$1" == "config" )
then
  printf "Removing configuration legacy...\n"
  rm -r ~/.config/nvim
  rm -r ~/.local/share/nvim
  rm -r ~/.local/state/nvim
  rm -r ~/.cache/nvim
  printf "Removing neovim artifacts...\n"
  rm -r ~/.dotfiles/squashfs-root
  rm ~/.dotfiles/nvim.appimage
fi

if [ "$1" == "all" ] || ( "$1" == "binary" )
then
  printf "Removing neovim app...\n"
  rm /usr/local/bin/nvim
  rm /usr/local/bin/squashfs-root-nvim
fi
