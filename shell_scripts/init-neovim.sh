#!/bin/bash



# MacOS
brew install ripgrep
brew install fzf

# add scripting provider - check what's supported :checkhealth provider
# install pip @see https://www.gungorbudak.com/blog/2018/08/02/correct-installation-and-configuration-of-pip2-and-pip3/
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo python3 get-pip.py
pip2 install neovim
pip3 install neovim
npm install -g neovim
gem install neovim

ln -s ~/.vim/init.vim ~/.config/nvim/init.vim
ln -s ~/.vim/coc-settings.json ~/.config/nvim/coc-settings.json
