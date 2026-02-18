#!/bin/bash

export INSTALLERS_FOLDER=~/.dotfiles

cd $INSTALLERS_FOLDER
if !(test -d antidote)
then
  printf "=========> clone mattmc3/antidote.git in antidote folder...\n"
  git clone --depth=1 https://github.com/mattmc3/antidote.git antidote
else
  printf "=========> folder antidote already exists, skipping...\n"
fi

printf "=========> update dir_colors symlinks...\n"
cd ~
rm ~/.dir_colors
ln -s $INSTALLERS_FOLDER/vimmy/colors/.dir_colors .dir_colors

printf "=========> lsd configuration...\n"
mkdir ~/.config/lsd
cd ~/.config/lsd
ln -s $INSTALLERS_FOLDER/vimmy/lsd/config.yaml
ls -s $INSTALLERS_FOLDER/vimmy/lsd/colors.yaml

