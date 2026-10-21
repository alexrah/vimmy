#!/bin/bash

if [ "$1" == "help" ] || ( test -z "$1" )
then
  printf "Please provide one of the following option:\n"
  printf "all : remove config and binary\n"
  printf "antidote: replace oh-my-zsh with antidote (requires zsh > 5.5) \n"
  printf "symlinks: replace dir_colors & lsd configs \n"
  printf "bat: update to support light themes \n"
  printf "tmux: update to support extensions \n"
  exit
fi

INSTALLERS_FOLDER=~/.dotfiles
cd $INSTALLERS_FOLDER

if [ "$1" == "all" ] || [ "$1" == "antidote" ]
then
  cd $INSTALLERS_FOLDER
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

if [[ "$1" == "all" || "$1" == "bat" ]]
then
  if ! command -v "bat" &> /dev/null || [[ $(bat --version) != *"0.26.1"* ]]
  then
    printf "=========> install bat...\n"
    ${SUDO} rm /usr/local/bin/bat
    cd $INSTALLERS_FOLDER
    curl -L https://github.com/sharkdp/bat/releases/download/v0.26.1/bat-v0.26.1-x86_64-unknown-linux-musl.tar.gz -o bat.tar.gz
    tar xvzf bat.tar.gz
    cd bat-v0.26.1-x86_64-unknown-linux-musl
    ${SUDO} mv bat /usr/local/bin/bat
    cd $INSTALLERS_FOLDER
  else
    printf "=========> bat already installed and up to date, skipping...\n"
  fi
fi

if [[ "$1" == "all" || "$1" == "tmux" ]]
then
  cd $INSTALLERS_FOLDER
  if ! command -v "tmux" &> /dev/null || [[ $(tmux -V) != *"3.6a"* ]]
  printf "=========> install tmux...\n"
  then
    # Pinned to v3.6a: v3.7c requires a newer glibc than these targets provide
    TMUX_VERSION="3.6a"
    curl -L https://github.com/tmux/tmux-builds/releases/download/v${TMUX_VERSION}/tmux-${TMUX_VERSION}-linux-x86_64.tar.gz -o tmux.tar.gz
    tar xvzf tmux.tar.gz
    ${SUDO} mv tmux /usr/local/bin/tmux
  else
    printf "=========> tmux already installed, skipping...\n"
  fi
fi

