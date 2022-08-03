#!/bin/bash

if [ "$1" == "help" ] || !( test -n "$1" )
then
  printf "========================\n"
  printf "IMPORTANT: user (dont use root) needs to be inside sudoers to be able to install packages\n"
  printf "all : install everything if not already installed\n"
  printf "help : show this message\n"
  printf "Please provide one of the following option or comma separated list of options to install specific packages:\n"
  printf "git : install only git\n"
  printf "zsh : install only zsh\n"
  printf "zsh-default : set zsh as default shell\n"
  printf "tools : (fzf requires git) install tmux, ripgrep, fzf, bat\n"
  printf "dotfiles : (requires git) install repos alexrah/vimmy & alexrah/oh-my-zsh & create symlinks\n"
  printf "node : (nvm requires dotfiles) install node stack ( nvm, node, npm, yarn )\n"
  printf "python : install python pip, python3, pip3 and neovim support\n"
  printf "ruby : install ruby and neovim support\n"
  printf "neovim : install or update nvim, configuration files, plugin manager\n"
  printf "example: ./init-4.0.sh all #install everything\n"
  printf "example: ./init-4.0.sh help #show this message\n"
  printf "example: ./init-4.0.sh node #install node stack ( nvm, node, npm, yarn )\n"
  printf "example: ./init-4.0.sh nvim,dotfiles #install nvim & install dotfiles\n"
  printf "========================\n"
  exit
fi

printf "install: $1\n"

IFS=',' read -ra aArgs <<< "$1"

# CREATE a condition to deal with OS
if ( test -e /etc/os-release )
then
  os_type=$(cat /etc/os-release | head -n 1 | sed -r 's/.*"(.*)\"/\1/g')
else
  os_type=$OSTYPE
fi

printf "OS: $os_type\n"
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
    sudo rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
    sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
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

printf "start installing packages...\n"

export INSTALLERS_FOLDER=~/.dotfiles
mkdir $INSTALLERS_FOLDER
cd $INSTALLERS_FOLDER

if [[ " ${aArgs[*]} " =~ "git" ]] || [[ $1 == "all" ]]
then
  if !(command -v "git" &> /dev/null)
  then
    printf "=========> install git...\n"
    sudo $PACKAGE_MANAGER -y install git
  else
    printf "---------- git already installed, skipping...\n"
  fi
fi

if [[ " ${aArgs[*]} " =~ "zsh" ]] || [[ $1 == "all" ]]
then
  if !(command -v "zsh" &> /dev/null)
  then
    printf "=========> install zsh...\n"
    sudo $PACKAGE_MANAGER -y install zsh
  else
    printf "---------- zsh already installed, skipping...\n"
  fi
fi

if [[ " ${aArgs[*]} " =~ "tools" ]] || [[ $1 == "all" ]]
then
  if !(command -v "tmux" &> /dev/null)
  then
    printf "=========> install tmux...\n"
    sudo $PACKAGE_MANAGER -y install tmux
  else
    printf "---------- tmux already installed, skipping...\n"
  fi

  if !(command -v "rg" &> /dev/null)
  then
    printf "=========> install ripgrep...\n"
    sudo $PACKAGE_MANAGER -y install ripgrep
  else
    printf "---------- ripgrep already installed, skipping...\n"
  fi

  if !(command -v "fzf" &> /dev/null)
  then
    printf "=========> install fzf...\n"
    git clone --depth 1 https://github.com/junegunn/fzf.git $INSTALLERS_FOLDER/fzf
    cd $INSTALLERS_FOLDER/fzf
    ./install --bin
    cp bin/fzf /usr/local/bin/fzf
  else
    printf "---------- fzf already installed, skipping...\n"
  fi

  if !(command -v "bat" &> /dev/null)
  then
    printf "=========> install bat...\n"
    cd $INSTALLERS_FOLDER
    curl -L https://github.com/sharkdp/bat/releases/download/v0.7.1/bat-v0.7.1-x86_64-unknown-linux-musl.tar.gz -o bat.tar.gz
    tar xvzf bat.tar.gz
    cd bat-v0.7.1-x86_64-unknown-linux-musl
    sudo mv bat /usr/local/bin/bat
  else
    printf "---------- bat already installed, skipping...\n"
  fi
fi

if [[ " ${aArgs[*]} " =~ "dotfiles" ]] || [[ $1 == "all" ]]
then
  #ZSH & DOTFILES
  printf "=========> install dotfiles...\n"
  cd $INSTALLERS_FOLDER
  if !(test -d vimmy)
  then
    printf "=========> clone alexrah/vimmy in vimmy folder...\n"
    git clone https://alexrah@github.com/alexrah/vimmy 
    cd ~
    ln -s $INSTALLERS_FOLDER/vimmy/.zshrc
    # ln -s $INSTALLERS_FOLDER/vimmy/.vimrc
    ln -s $INSTALLERS_FOLDER/vimmy/.dir_colors.NEW .dir_colors
    ln -s $INSTALLERS_FOLDER/vimmy/.tmux.conf
    ln -s $INSTALLERS_FOLDER/vimmy/.gitconfig
  else
    printf "---------- folder vimmy already exists, skipping...\n"
  fi
  cd $INSTALLERS_FOLDER
  if !(test -d oh-my-zsh)
  then
    printf "=========> clone alexrah/oh-my-zsh in oh-my-zsh folder...\n"
    git clone https://alexrah@github.com/alexrah/oh-my-zsh oh-my-zsh
    cd oh-my-zsh
    git fetch --all
    git branch --all
    git checkout origin/theme-dstkph
    git submodule update --init
  else
    printf "---------- folder oh-my-zsh already exists, skipping...\n"
  fi
fi

cd $INSTALLERS_FOLDER

if [[ " ${aArgs[*]} " =~ "node" ]] || [[ $1 == "all" ]]
then
  # Need to be done after sourcing .zshrc because NVM need enviroment var $NVM_DIR
  if !(command -v "nvm" &> /dev/null)
  then
    printf "=========> install nvm (Node Version Manager)...\n"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
  else
    printf "---------- nvm already installed, skipping...\n"
  fi
  if !(command -v "node" &> /dev/null)
  then
    printf "=========> install node...\n"
    nvm install --lts
  else
    printf "---------- node already installed, skipping...\n"
  fi
  if !(command -v "yarn" &> /dev/null)
  then
    printf "=========> install yarn...\n"
    sudo $PACKAGE_MANAGER -y install yarn
  else
    printf "---------- yarn already installed, skipping...\n"
  fi

  printf "=========> install node neovim support...\n"
  npm install -g neovim

fi

if [[ " ${aArgs[*]} " =~ "python" ]] || [[ $1 == "all" ]]
then

# PYTHON2 SUPPORT
  if !(command -v "pip" &> /dev/null)
  then
    printf "=========> install pip...\n"
    curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip2.py
	  sudo python get-pip2.py
  else
    printf "---------- pip already installed, skipping...\n"
  fi
  
  printf "=========> install python neovim support...\n"
  pip install neovim

  if !(command -v "python3" &> /dev/null)
  then
    printf "=========> install python3...\n"
    sudo $PACKAGE_MANAGER -y install python3
  else
    printf "---------- python3 already installed, skipping...\n"
  fi

  if !(command -v "pip3" &> /dev/null)
  then
    printf "=========> install pip3...\n"
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip3.py
	  sudo python3 get-pip3.py
  else
    printf "---------- pip3 already installed, skipping...\n"
  fi

  printf "=========> install python3 neovim support...\n"
  pip3 install neovim

# printf "Python: install virtualenv & create .virtualenvs...\n"
# printf "================================\n"
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
fi

if [[ " ${aArgs[*]} " =~ "ruby" ]] || [[ $1 == "all" ]]
then
  # RUBY SUPPORT
  if !(command -v "ruby" &> /dev/null)
  then
    printf "=========> install ruby...\n"
    sudo $PACKAGE_MANAGER -y install ruby
  else
    printf "---------- ruby already installed, skipping...\n"
  fi

  printf "=========> install ruby neovim support...\n"
  gem install neovim
fi

if [[ " ${aArgs[*]} " =~ "neovim" ]] || [[ $1 == "all" ]]
then
  printf "=========> install neovim...\n"
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod 755 nvim.appimage
  sudo mv nvim.appimage /usr/local/bin/nvim

  printf "=========> install symlinks: init.vim & coc-settings.json in "$NVIM_CONFIG_PATH"\n"
  mkdir -p $NVIM_CONFIG_PATH
  ln -s $INSTALLERS_FOLDER/vimmy/init.vim $NVIM_CONFIG_PATH/init.vim
  ln -s $INSTALLERS_FOLDER/vimmy/coc-settings.json $NVIM_CONFIG_PATH/coc-settings.json
  mkdir -p ~/.vim_runtime/undodir

  if !(command -v "which" &> /dev/null)
  then
    printf "=========> install which (required by CoC plugin)...\n"
    sudo $PACKAGE_MANAGER -y install which
  else
    printf "---------- which already installed, skipping...\n"
  fi

  # install vim-plug @see https://github.com/junegunn/vim-plug
  printf "=========> install NeoVim plugin manager: junegunn/vim-plug...\n"
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  printf "=========> NOTE: run :PlugInstall first time launching nvim\n"
fi

if [[ " ${aArgs[*]} " =~ "zsh-default" ]] || [[ $1 == "all" ]]
then
  printf "=========> set zsh as default shell...\n"
  chsh -s /bin/zsh
fi

printf "========= DONE! =========\n"
