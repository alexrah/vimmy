#!/bin/bash

# let's check if arg passed, otherwise set it to all
# possible args:
#   all
#     
#
#
#
#
#
#   tools
#   dotfiles 
#   symlinks
#   uninstall
#   uninstall_legacy


if [ $1 == "help" ]
then
  printf "Please provide one of the following option:\n"
  printf "all : install everything if not already installed\n"
  printf "tools : install only git, zsh, nvim, tmux, ripgrep, fzf, nodejs, yarn, python3, bat\n"
  printf "dotfiles : install repos alexrah/vimmy & alexrah/oh-my-zsh\n"
  printf "symlinks : add symlinks from .dotfiles to ~\n"
  printf "nvim_support : install nvim support for \n"
  printf "uninstall\n"
  printf "uninstall_legacy\n"
fi

if ! test -n "$1"
then
  $1 == 'all'
fi

printf "install: $1\n"

# CREATE a condition to deal with OS
printf "start installing packages...\n"
if [[ test -e /etc/os-release ]]
then
  os_type=$(cat /etc/os-release | head -n 1 | sed -r 's/.*"(.*)\"/\1/g')
else
  os_type=$OSTYPE
fi

printf "OS: "$os_type"\n"
printf "================================\n"
case "$os_type" in
	"cygwin")
		printf "OS DETECTED: WINDOWS CygWin\n";;
	"Ubuntu")
		printf "OS DETECTED: DEBIAN/UBUNTU\n"
		export PACKAGE_MANAGER=apt-get
		export NVIM_CONFIG_PATH=~/.config/nvim
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
    echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo add-apt-repository ppa:x4121/ripgrep
    curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
    sudo add-apt-repository ppa:git-core/ppa
    sudo apt-get update
    ;;
	"CentOS Linux")
		printf "OS DETECTED: CENTOS\n"
		export PACKAGE_MANAGER=yum
		export NVIM_CONFIG_PATH=~/.config/nvim
    curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
    rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
    yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
    curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -
    ;;
	"linux-android")
		printf "OS DETECTED: TERMUX\n"
		export PACKAGE_MANAGER=apt
		export NVIM_CONFIG_PATH=~/.config/nvim;;
	darwin*)
		printf "OS DETECTED: MacOS\n"
		export PACKAGE_MANAGER=brew
		export NVIM_CONFIG_PATH=~/.config/nvim;;
esac

export INSTALLERS_FOLDER=~/.dotfiles
mkdir $INSTALLERS_FOLDER
cd $INSTALLERS_FOLDER

printf "=========> install git...\n"
sudo $PACKAGE_MANAGER -y install git

printf "=========> install zsh...\n"
sudo $PACKAGE_MANAGER -y install zsh

printf "=========> install neovim...\n"
# sudo $PACKAGE_MANAGER -y install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod 755 nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

printf "=========> install tmux...\n"
sudo $PACKAGE_MANAGER -y install tmux

printf "=========> install ripgrep...\n"
# sudo $PACKAGE_MANAGER install ripgrep
sudo $PACKAGE_MANAGER -y install ripgrep

printf "=========> install fzf...\n"
# sudo $PACKAGE_MANAGER install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $INSTALLERS_FOLDER/fzf
cd $INSTALLERS_FOLDER/fzf
./install --bin
cp bin/fzf /usr/local/bin/fzf

printf "=========> install nodejs...\n"
sudo $PACKAGE_MANAGER -y install nodejs

printf "=========> install yarn...\n"
cd $INSTALLERS_FOLDER
sudo $PACKAGE_MANAGER -y install yarn

# sudo $PACKAGE_MANAGER install python

printf "=========> install python3...\n"
sudo $PACKAGE_MANAGER -y install python3

# sudo $PACKAGE_MANAGER install ruby

printf "=========> install bat...\n"
# sudo $PACKAGE_MANAGER install bat
cd $INSTALLERS_FOLDER
curl -L https://github.com/sharkdp/bat/releases/download/v0.7.1/bat-v0.7.1-x86_64-unknown-linux-musl.tar.gz -o bat.tar.gz
tar xvzf bat.tar.gz
cd bat-v0.7.1-x86_64-unknown-linux-musl
sudo mv bat /usr/local/bin/bat


#ZSH & DOTFILES
printf "clone alexrah/vimmy & alexrah/oh-my-zsh, config zsh, tmux, vim (legacy)\n"
printf "================================\n"
cd $INSTALLERS_FOLDER
git clone https://alexrah@github.com/alexrah/vimmy 
git clone https://alexrah@github.com/alexrah/oh-my-zsh oh-my-zsh
cd oh-my-zsh
git fetch --all
git branch --all
git checkout origin/theme-dstkph
git submodule update --init
cd ~
ln -s $INSTALLERS_FOLDER/vimmy/.zshrc
# ln -s $INSTALLERS_FOLDER/vimmy/.vimrc
ln -s $INSTALLERS_FOLDER/vimmy/.dir_colors.NEW .dir_colors
ln -s $INSTALLERS_FOLDER/vimmy/.tmux.conf
ln -s $INSTALLERS_FOLDER/vimmy/.gitconfig

# Symlinks init.vim & coc-settings.json
printf "symlinks: init.vim & coc-settings.json in "$NVIM_CONFIG_PATH"\n"
printf "================================\n"
mkdir -p $NVIM_CONFIG_PATH
ln -s $INSTALLERS_FOLDER/vimmy/init.vim $NVIM_CONFIG_PATH/init.vim
ln -s $INSTALLERS_FOLDER/vimmy/coc-settings.json $NVIM_CONFIG_PATH/coc-settings.json

mkdir -p ~/.vim_runtime/undodir
cd ~

# NEOVIM 
printf "NeoVIM configurations: Python, Python3, NodeJS, Ruby, CoC\n"
printf "================================\n"
# add scripting provider - check what's supported :checkhealth provider
# install pip @see https://www.gungorbudak.com/blog/2018/08/02/correct-installation-and-configuration-of-pip2-and-pip3/

cd $INSTALLERS_FOLDER


printf "Python: install pip & pip3, add neovim python & python3 support...\n"
printf "================================\n" 
# PYTHON2 SUPPORT
if ! command -v pip &> /dev/null
then
	printf "pip not found, installing...\n"
  curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip2.py
	sudo python get-pip2.py
fi

# PYTHON3 SUPPORT
if ! command -v pip3 &> /dev/null
then
	printf "pip3 not found, installing...\n"
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip3.py
	sudo python3 get-pip3.py
fi
pip install neovim
pip3 install neovim

printf "Python: install virtualenv & create .virtualenvs...\n"
printf "================================\n"
# PYTHON VIRTUALENV SUPPORT
# pip3 install virtualenv
# mkdir -p ~/.virtualenvs/neovm-python2
# cd ~/.virtualenvs/neovim-python2
# virtualenv py2 -p $(which python)
# source py2/bin/activate
# pip install neovim
#
# mkdir -p ~/.virtualenvs/neovim-python3
# cd ~/.virtualenvs/neovim-python3
# virtualenv py3 -p $(which python3)
# source py3/bin/activate
# pip install neovim

# NODE SUPPORT
printf "NodeJS: install neovim support (required by CoC)\n"
printf "================================\n"
sudo npm install -g neovim

# RUBY SUPPORT
printf "Ruby: install neovim support\n"
printf "================================\n"
if ! command -v gem &> /dev/null
then
	printf "gem could not be found\n"
	exit
else
	gem install neovim
fi

# install vim-plug @see https://github.com/junegunn/vim-plug
printf "Installing NeoVim plugin manager: junegunn/vim-plug...\n"
printf "================================\n"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

printf "NOTE: run :PlugInstall first time launching nvim\n"

chsh -s /bin/zsh
zsh
printf "DONE!\n"
