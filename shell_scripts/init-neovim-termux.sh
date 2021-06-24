#!/bin/bash




# add scripting provider - check what's supported :checkhealth provider
# install pip @see https://www.gungorbudak.com/blog/2018/08/02/correct-installation-and-configuration-of-pip2-and-pip3/
pip3 install neovim
npm install -g neovim
gem install neovim

mkdir -p ~/.config/nvim
ln -s ~/.vim/init.vim ~/.config/nvim/init.vim
ln -s ~/.vim/coc-settings.json ~/.config/nvim/coc-settings.json

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
