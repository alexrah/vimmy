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
git submodule update --init
cd ..
ln -s .vim/.zshrc
ln -s .vim/.vimrc
ln -s .vim/.ctags
ln -s .vim/.dir_colors.NEW .dir_colors
ln -s .vim/.tmux.conf
mkdir -p ~/.vim_runtime/undodir
cd .vim
git submodule update --init
sed -i 's/base_color=/base_color=linux:normal=white,black:marked=yellow,black:input=,green:menu=black:menusel=white:menuhot=red,:menuhotsel=black,red:dfocus=white,black:dhotnormal=white,black:dhotfocus=white,black:executable=,black:directory=white,black:link=white,black:device=white,black:special=white,black:core=,black:stalelink=red,black:editnormal=white,black/g' ~/.config/mc/ini
chsh -s /bin/zsh
