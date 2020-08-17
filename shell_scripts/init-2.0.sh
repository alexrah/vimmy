#!/bin/bash

# CREATE a condition to deal with OS
echo "start installing packages...\n"
echo "OS: "$OSTYPE"\n"
case "$OSTYPE" in
	cygwin)
		# WINDOWS CygWin
		;;
	linux)
		# DEBIAN/UBUNTU
		export PACKAGE_MANAGER=apt-get
		export NVIM_CONFIG_PATH=.config/nvim;;
	linux-android)
		# TERMUX
		export PACKAGE_MANAGER=apt
		export NVIM_CONFIG_PATH=.config/nvim;;
	darwin*)
		# MacOS
		export PACKAGE_MANAGER=brew
		export NVIM_CONFIG_PATH=.config/nvim;;
esac

$PACKAGE_MANAGER install git
$PACKAGE_MANAGER install zsh
$PACKAGE_MANAGER install neovim
$PACKAGE_MANAGER install tmux
$PACKAGE_MANAGER install ripgrep
$PACKAGE_MANAGER install fzf
$PACKAGE_MANAGER install nodejs
$PACKAGE_MANAGER install python
$PACKAGE_MANAGER install python3
$PACKAGE_MANAGER install bat


#ZSH & DOTFILES
echo "clone alexrah/vimmy & alexrah/oh-my-zsh, config zsh, tmux, vim (legacy)\n"
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
chsh -s /bin/zsh


# NEOVIM 
echo "NeoVIM configurations: Python, Python3, NodeJS, Ruby, CoC\n"
# add scripting provider - check what's supported :checkhealth provider
# install pip @see https://www.gungorbudak.com/blog/2018/08/02/correct-installation-and-configuration-of-pip2-and-pip3/

# PYTHON SUPPORT
if ! command -v pip3 &> /dev/null
then
	echo "pip3 not found, installing...\n"
	wget https://bootstrap.pypa.io/get-pip.py
	sudo python3 get-pip.py
fi

# sudo python get-pip.py
# pip2 install virtualenv
echo "Python: install virtualenv & create .virtualenvs for neovim python & python3 support...\n"
pip3 install virtualenv

# PYTHON VIRTUALENV SUPPORT
mkdir -p ~/.virtualenvs/neovim-python2
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
echo "NodeJS: install neovim support (required by CoC)\n"
npm install -g neovim

# RUBY SUPPORT
if ! command -v gem &> /dev/null
then
	echo "gem could not be found\n"
	exit
else
	gem install neovim
fi


ln -s ~/.vim/init.vim ~/$NVIM_CONFIG_PATH/init.vim
ln -s ~/.vim/coc-settings.json ~/$NVIM_CONFIG_PATH/coc-settings.json
