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
printf "OS: "$OSTYPE"\n"
printf "================================\n"
case "$OSTYPE" in
	cygwin)
		printf "OS DETECTED: WINDOWS CygWin\n"
		;;
	linux)
		printf "OS DETECTED: DEBIAN/UBUNTU\n"
		export PACKAGE_MANAGER=apt-get
		export NVIM_CONFIG_PATH=.config/nvim;;
	linux-gnu)
		printf "OS DETECTED: CENTOS\n"
		export PACKAGE_MANAGER=yum
		export NVIM_CONFIG_PATH=.config/nvim
    curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
    rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
    yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo;;
	linux-android)
		printf "OS DETECTED: TERMUX\n"
		export PACKAGE_MANAGER=apt
		export NVIM_CONFIG_PATH=.config/nvim;;
	darwin*)
		printf "OS DETECTED: MacOS\n"
		export PACKAGE_MANAGER=brew
		export NVIM_CONFIG_PATH=.config/nvim;;
esac

export INSTALLERS_FOLDER=~/.dotfiles
mkdir $INSTALLERS_FOLDER
cd $INSTALLERS_FOLDER

printf "=========> install git...\n"
$PACKAGE_MANAGER -y install git

printf "=========> install zsh...\n"
$PACKAGE_MANAGER -y install zsh

printf "=========> install neovim...\n"
# $PACKAGE_MANAGER -y install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod 755 nvim.appimage
mv nvim.appimage /usr/local/bin/nvim

printf "=========> install tmux...\n"
$PACKAGE_MANAGER -y install tmux

printf "=========> install ripgrep...\n"
# $PACKAGE_MANAGER install ripgrep
$PACKAGE_MANAGER -y install ripgrep

printf "=========> install fzf...\n"
# $PACKAGE_MANAGER install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $INSTALLERS_FOLDER/fzf
cd $INSTALLERS_FOLDER/fzf
./install --all --no-update-rc
cp bin/fzf /usr/local/bin/fzf

printf "=========> install nodejs...\n"
curl -sL https://rpm.nodesource.com/setup_14.x | bash -
$PACKAGE_MANAGER -y install nodejs


printf "=========> install yarn...\n"
cd $INSTALLERS_FOLDER
$PACKAGE_MANAGER -y install yarn

# $PACKAGE_MANAGER install python

printf "=========> install python3...\n"
$PACKAGE_MANAGER -y install python3

# $PACKAGE_MANAGER install ruby

printf "=========> install bat...\n"
# $PACKAGE_MANAGER install bat
cd $INSTALLERS_FOLDER
curl -L https://github.com/sharkdp/bat/releases/download/v0.7.1/bat-v0.7.1-x86_64-unknown-linux-musl.tar.gz -o bat.tar.gz
tar xvzf bat.tar.gz
cd bat-v0.7.1-x86_64-unknown-linux-musl
mv bat /usr/local/bin/bat


#ZSH & DOTFILES
printf "clone alexrah/vimmy & alexrah/oh-my-zsh, config zsh, tmux, vim (legacy)\n"
printf "================================\n"
cd $INSTALLERS_FOLDER
git clone https://alexrah@github.com/alexrah/vimmy 
cd ~
git clone https://alexrah@github.com/alexrah/oh-my-zsh .oh-my-zsh
cd .oh-my-zsh
git fetch --all
git branch --all
git checkout origin/theme-dstkph
git submodule update --init
cd ~
ln -s $INSTALLERS_FOLDER/vimmy/.zshrc
ln -s $INSTALLERS_FOLDER/vimmy/.vimrc
ln -s $INSTALLERS_FOLDER/vimmy/.dir_colors.NEW .dir_colors
ln -s $INSTALLERS_FOLDER/vimmy/.tmux.conf
ln -s $INSTALLERS_FOLDER/vimmy/.gitconfig
mkdir -p ~/.vim_runtime/undodir
cd $INSTALLERS_FOLDER/vimmy
git submodule update --init
chsh -s /bin/zsh
cd ~

# NEOVIM 
printf "NeoVIM configurations: Python, Python3, NodeJS, Ruby, CoC\n"
printf "================================\n"
# add scripting provider - check what's supported :checkhealth provider
# install pip @see https://www.gungorbudak.com/blog/2018/08/02/correct-installation-and-configuration-of-pip2-and-pip3/

# PYTHON SUPPORT
if ! command -v pip3 &> /dev/null
then
	printf "pip3 not found, installing...\n"
	wget https://bootstrap.pypa.io/get-pip.py
	sudo python3 get-pip.py
fi

# sudo python get-pip.py
# pip2 install virtualenv
printf "Python: install virtualenv & create .virtualenvs for neovim python & python3 support...\n"
printf "================================\n"
pip3 install virtualenv

# PYTHON VIRTUALENV SUPPORT
mkdir -p ~/.virtualenvs/neovm-python2
cd ~/.virtualenvs/neovim-python2
virtualenv py2 -p $(which python)
source py2/bin/activate
pip install neovim

mkdir -p ~/.virtualenvs/neovim-python3
cd ~/.virtualenvs/neovim-python3
virtualenv py3 -p $(which python3)
source py3/bin/activate
pip install neovim

# NODE SUPPORT
printf "NodeJS: install neovim support (required by CoC)\n"
printf "================================\n"
npm install -g neovim

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

# Symlinks init.vim & coc-settings.json
printf "symlinks: init.vim & coc-settings.json in "$NVIM_CONFIG_PATH"\n"
printf "================================\n"
mkdir -p ~/$NVIM_CONFIG_PATH
ln -s $INSTALLERS_FOLDER/vimmy/init.vim ~/$NVIM_CONFIG_PATH/init.vim
ln -s $INSTALLERS_FOLDER/vimmy/coc-settings.json ~/$NVIM_CONFIG_PATH/coc-settings.json

# install vim-plug @see https://github.com/junegunn/vim-plug
printf "Installing NeoVim plugin manager: junegunn/vim-plug...\n"
printf "================================\n"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

printf "NOTE: run :PlugInstall first time launching nvim\n"
printf "DONE!\n"
zsh
