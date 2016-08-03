#!/bin/bash
sudo apt-get install zsh
sudo apt-get install vim
sudo apt-get install tmux
cd ~
git clone https://alexrah@github.com/alexrah/vimmy .vim
git clone https://alexrah@github.com/alexrah/oh-my-zsh .oh-my-zsh
cd .oh-my-zsh
git fetch --all
git branch --all
git checkout origin/theme-dstkph
cd ..
ln -s .vim/.zshrc
ln -s .vim/.vimrc
ln -s .vim/.ctags
ln -s .vim/.dir_colors.NEW .dir_colors
ln -s .vim/.tmux.conf
mkdir -p ~/.vim_runtime/undodir
cd .vim
git submodule update --init
chsh -s /bin/zsh
