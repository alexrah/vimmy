#!/bin/bash

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
		export NVIM_CONFIG_PATH=.config/nvim;;

	linux-android)
		printf "OS DETECTED: TERMUX\n"
		export PACKAGE_MANAGER=apt
		export NVIM_CONFIG_PATH=.config/nvim;;
	darwin*)
		printf "OS DETECTED: MacOS\n"
		export PACKAGE_MANAGER=brew
		export NVIM_CONFIG_PATH=.config/nvim;;
esac

printf "=========> install git...\n"
# $PACKAGE_MANAGER install git
printf "=========> install zsh...\n"
# $PACKAGE_MANAGER install zsh
printf "=========> install neovim...\n"
# $PACKAGE_MANAGER install neovim
printf "=========> install tmux...\n"
$PACKAGE_MANAGER install tmux

printf "=========> install ripgrep...\n"
# $PACKAGE_MANAGER install ripgrep
yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
sudo yum install ripgrep

printf "=========> install fzf...\n"
# $PACKAGE_MANAGER install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/fzf
cd fzf/
./install
cd ~

printf "=========> install nodejs...\n"
$PACKAGE_MANAGER install nodejs

# $PACKAGE_MANAGER install python
# $PACKAGE_MANAGER install python3
# $PACKAGE_MANAGER install ruby

printf "=========> install bat...\n"
# $PACKAGE_MANAGER install bat
wget -O bat.tar.gz https://github.com/sharkdp/bat/releases/download/v0.7.1/bat-v0.7.1-x86_64-unknown-linux-musl.tar.gz
tar xvzf bat.tar.gz
cd bat/
sudo mv bat /usr/local/bin/bat
cd ~


#ZSH & DOTFILES
printf "clone alexrah/vimmy & alexrah/oh-my-zsh, config zsh, tmux, vim (legacy)\n"
printf "================================\n"
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
ln -s .vim/.dir_colors.NEW .dir_colors
ln -s .vim/.tmux.conf
mkdir -p ~/.vim_runtime/undodir
cd .vim
git submodule update --init
chsh -s /bin/zsh


# NEOVIM 
printf "NeoVIM configurations: NodeJS, CoC\n"
printf "================================\n"

# NODE SUPPORT
printf "NodeJS: install neovim support (required by CoC)\n"
printf "================================\n"
npm install -g neovim

# Symlinks init.vim & coc-settings.json
printf "symlinks: init.vim & coc-settings.json in "$NVIM_CONFIG_PATH"\n"
printf "================================\n"
ln -s ~/.vim/init.vim ~/$NVIM_CONFIG_PATH/init.vim
ln -s ~/.vim/coc-settings.json ~/$NVIM_CONFIG_PATH/coc-settings.json

# install vim-plug @see https://github.com/junegunn/vim-plug
printf "Installing NeoVim plugin manager: junegunn/vim-plug...\n"
printf "================================\n"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

printf "NOTE: run :PlugInstall first time launching nvim\n"
printf "DONE!\n"
zsh
