#!/bin/bash

if [ "$1" == "help" ] || ( test -z "$1" )
then
  printf "Please provide one of the following option:\n"
  printf "all : remove config and binary\n"
  printf "symlinks: replace dir_colors & lsd configs \n"
  printf "antidote: replace oh-my-zsh with antidote (requires zsh > 5.5) \n"
  exit
fi

INSTALLERS_FOLDER=~/.dotfiles
cd $INSTALLERS_FOLDER

if [ "$1" == "all" ] || [ "$1" == "antidote" ]
then
  if !(test -d antidote)
  then
    printf "=========> clone mattmc3/antidote.git in antidote folder...\n"
    git clone --depth=1 https://github.com/mattmc3/antidote.git antidote
  else
    printf "=========> folder antidote already exists, skipping...\n"
  fi
fi

if [ "$1" == "all" ] || [ "$1" == "symlinks" ]
then
  printf "=========> update dir_colors symlinks...\n"
  cd ~
  rm ~/.dir_colors
  ln -s $INSTALLERS_FOLDER/vimmy/colors/.dir_colors .dir_colors

  printf "=========> lsd configuration...\n"
  mkdir ~/.config/lsd
  cd ~/.config/lsd
  ln -s $INSTALLERS_FOLDER/vimmy/lsd/config.yaml
  ln -s $INSTALLERS_FOLDER/vimmy/lsd/colors.yaml
fi
