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
  printf "lnav : install Log File Navigator (lnav) advanced log file viewer with Wordpress debug.log support\n"
  printf "node : (nvm requires dotfiles) install node stack ( nvm, node, npm, yarn )\n"
  printf "python : install python pip, python3, pip3 and neovim support\n"
  #  printf "ruby : install ruby and neovim support\n"
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
  os_type=$(cat /etc/os-release | grep '^NAME=' | sed -r 's/.*"(.*)\"/\1/g')
else
  os_type=$OSTYPE
fi

printf "OS: $os_type\n"
printf "================================\n"
case "$os_type" in
	"cygwin")
		printf "OS DETECTED: WINDOWS CygWin\n"
    exit
    ;;
	"Ubuntu")
		printf "OS DETECTED: UBUNTU\n"
		export PACKAGE_MANAGER="sudo apt-get"
		export NVIM_CONFIG_PATH=~/.config/nvim
    os_family=linux
    # no longer required on newer versions
    # sudo add-apt-repository ppa:x4121/ripgrep
    # sudo add-apt-repository ppa:git-core/ppa
    sudo apt-get update
    ;;
  "Debian GNU/Linux")
		printf "OS DETECTED: DEBIAN\n"
		export PACKAGE_MANAGER="sudo apt-get"
		export NVIM_CONFIG_PATH=~/.config/nvim
    os_family=linux
    sudo apt-get update
    ;;
	"CentOS Linux")
		printf "OS DETECTED: CENTOS\n"
		export PACKAGE_MANAGER="sudo yum"
		export NVIM_CONFIG_PATH=~/.config/nvim
    os_family=linux
    sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
    sudo yum install https://packages.endpointdev.com/rhel/7/os/x86_64/endpoint-repo.x86_64.rpm
    ;;
	"linux-android")
		printf "OS DETECTED: TERMUX\n"
		export PACKAGE_MANAGER=pkg
		export NVIM_CONFIG_PATH=~/.config/nvim
    os_family=linux
    ;;
	darwin*)
		printf "OS DETECTED: MacOS\n"
		export PACKAGE_MANAGER=brew
		export NVIM_CONFIG_PATH=~/.config/nvim
    os_family=mac
    ;;
  *)
    printf "No OS DETECTED\n"
    exit
    ;;
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
    $PACKAGE_MANAGER -y install git
  else
    printf "=========> git already installed, skipping...\n"
  fi
fi

if [[ " ${aArgs[*]} " =~ "zsh" ]] || [[ $1 == "all" ]]
then
  if !(command -v "zsh" &> /dev/null)
  then
    printf "=========> install zsh...\n"
    $PACKAGE_MANAGER -y install zsh
  else
    printf "=========> zsh already installed, skipping...\n"
  fi
fi

if [[ " ${aArgs[*]} " =~ "tools" ]] || [[ $1 == "all" ]]
then
  if !(command -v "tmux" &> /dev/null)
  then
    printf "=========> install tmux...\n"
    $PACKAGE_MANAGER -y install tmux
  else
    printf "=========> tmux already installed, skipping...\n"
  fi

  if !(command -v "rg" &> /dev/null)
  then
    printf "=========> install ripgrep...\n"
    $PACKAGE_MANAGER -y install ripgrep
  else
    printf "=========> ripgrep already installed, skipping...\n"
  fi


  if !(test -d fzf)
  then
    printf "=========> clone junegunn/fzf.git in fzf folder...\n"
    git clone --depth 1 https://github.com/junegunn/fzf.git $INSTALLERS_FOLDER/fzf
  else
    printf "=========> fzf folder already exists, skipping...\n"
  fi
  if !(command -v "fzf" &> /dev/null)
  then
    printf "=========> install fzf...\n"
    cd $INSTALLERS_FOLDER/fzf
    ./install --bin
    sudo cp bin/fzf /usr/local/bin/fzf
  else
    printf "=========> fzf already installed, skipping...\n"
  fi

  if !(command -v "bat" &> /dev/null)
  then
    printf "=========> install bat...\n"
    cd $INSTALLERS_FOLDER
    curl -L https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-x86_64-unknown-linux-musl.tar.gz -o bat.tar.gz
    tar xvzf bat.tar.gz
    cd bat-v0.24.0-x86_64-unknown-linux-musl
    sudo mv bat /usr/local/bin/bat
  else
    printf "=========> bat already installed, skipping...\n"
  fi

  if !(command -v "jq" &> /dev/null)
  then
    printf "=========> install jq (JSON processor)...\n"
    $PACKAGE_MANAGER -y install jq
  else
    printf "=========> jq (JSON processor) already installed, skipping...\n"
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
    rm -f .zshrc
    ln -s $INSTALLERS_FOLDER/vimmy/.zshrc
    # ln -s $INSTALLERS_FOLDER/vimmy/.vimrc
    ln -s $INSTALLERS_FOLDER/vimmy/.dir_colors.NEW .dir_colors
    ln -s $INSTALLERS_FOLDER/vimmy/.tmux.conf
    ln -s $INSTALLERS_FOLDER/vimmy/.gitconfig
  else
    printf "=========> folder vimmy already exists, skipping...\n"
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
    printf "=========> folder oh-my-zsh already exists, skipping...\n"
  fi
fi

cd $INSTALLERS_FOLDER

if [[ " ${aArgs[*]} " =~ "lnav" ]] || [[ $1 == "all" ]]
then
  if !(command -v "lnav" &> /dev/null)
  then
    printf "=========> install lnav...\n"
    cd $INSTALLERS_FOLDER
    curl -LO https://github.com/tstack/lnav/releases/download/v0.12.2/lnav-0.12.2-linux-musl-x86_64.zip
    unzip lnav-0.12.2-linux-musl-x86_64.zip
    sudo mv lnav-0.12.2/lnav /usr/local/bin/lnav
  else
    printf "=========> lnav already installed, skipping...\n"
  fi

  if !(test -d ~/.config/lnav)
  then
    # need to launch lnav once to generate defult config in .config folder, then symlinks can be created
    timeout 1s lnav
    printf "=========> lnav symlinks configuration...\n"
    ln -s $INSTALLERS_FOLDER/vimmy/lnav/config.json ~/.config/lnav/config.json
    ln -s $INSTALLERS_FOLDER/vimmy/lnav/wpdebuglog.json ~/.config/lnav/formats/installed/wpdebuglog.json
    ln -s $INSTALLERS_FOLDER/vimmy/lnav/config.json ~/.lnav/config.json
    ln -s $INSTALLERS_FOLDER/vimmy/lnav/wpdebuglog.json ~/.lnav/formats/installed/wpdebuglog.json
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
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  else
    printf "=========> nvm already installed, skipping...\n"
  fi
  if !(command -v "node" &> /dev/null)
  then
    printf "=========> install node...\n"
    nvm install --lts
  else
    printf "=========> node already installed, skipping...\n"
  fi
  if !(command -v "yarn" &> /dev/null)
  then
    printf "=========> install yarn...\n"
    corepack enable
  else
    printf "=========> yarn already installed, skipping...\n"
  fi

  printf "=========> install node neovim support...\n"
  npm install --location=global neovim

fi

if [[ " ${aArgs[*]} " =~ "python" ]] || [[ $1 == "all" ]]
then

# PYTHON2 SUPPORT
  # if !(command -v "pip" &> /dev/null)
  # then
  #   printf "=========> install pip...\n"
  #   curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip2.py
	#   sudo python get-pip2.py
  # else
  #   printf "=========> pip already installed, skipping...\n"
  # fi
  #
  # printf "=========> install python neovim support...\n"
  # pip install neovim

  if !(command -v "python3" &> /dev/null)
  then
    printf "=========> install python3...\n"
    $PACKAGE_MANAGER -y install python3
  else
    printf "=========> python3 already installed, skipping...\n"
  fi

  if !(command -v "pip3" &> /dev/null)
  then
    printf "=========> install pip3...\n"
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip3.py
	  sudo python3 get-pip3.py
  else
    printf "=========> pip3 already installed, skipping...\n"
  fi

  printf "=========> install python3 neovim support...\n"
  sudo pip3 install neovim

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

# if [[ " ${aArgs[*]} " =~ "ruby" ]] || [[ $1 == "all" ]]
# then
#   if !(command -v "ruby" &> /dev/null)
#   then
#     printf "=========> install ruby...\n"
#     $PACKAGE_MANAGER -y install ruby
#   else
#     printf "=========> ruby already installed, skipping...\n"
#   fi
#
#   printf "=========> install ruby neovim support...\n"
#   gem install neovim
# fi

if [[ " ${aArgs[*]} " =~ "neovim" ]] || [[ $1 == "all" ]]
then

  if !(command -v "nvim" &> /dev/null)
  then
    printf "=========> install neovim...\n"
    
    if [[ $os_family == "linux"]]
    then
      # need to check currenct glibc version
      glibc_version=$(ldd --version | grep '^ldd' | sed -r 's/ldd \(.*\) (.*)/\1/g')
      # install bc for floating point arithmetic
      $PACKAGE_MANAGER -y install bc

      if (( $(echo "$glibc_version < 2.32" | bc -l) ))
      then
        curl -L -o nvim.appimage https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage
      else
        curl -L -o nvim.appimage https://github.com/neovim/neovim/releases/latest/download/NVIM-linux-x86_64.appimage
      fi

    else
      # if system is MacOS always install the latest version
      curl -L -o nvim.appimage https://github.com/neovim/neovim/releases/latest/download/NVIM-linux-x86_64.appimage
    fi

    chmod 755 nvim.appimage
    ./nvim.appimage --appimage-extract
    sudo mv squashfs-root /usr/local/bin/squashfs-root-nvim
    sudo ln -s /usr/local/bin/squashfs-root-nvim/usr/bin/nvim /usr/local/bin/nvim
  fi

  printf "=========> install symlinks: init.vim & coc-settings.json in "$NVIM_CONFIG_PATH"\n"
  mkdir -p $NVIM_CONFIG_PATH
  ln -s $INSTALLERS_FOLDER/vimmy/init.vim $NVIM_CONFIG_PATH/init.vim
  ln -s $INSTALLERS_FOLDER/vimmy/coc-settings.json $NVIM_CONFIG_PATH/coc-settings.json
  mkdir -p ~/.vim_runtime/undodir

  if !(command -v "which" &> /dev/null)
  then
    printf "=========> install which (required by CoC plugin)...\n"
    $PACKAGE_MANAGER -y install which
  else
    printf "=========> which already installed, skipping...\n"
  fi

  # install vim-plug @see https://github.com/junegunn/vim-plug
  printf "=========> install NeoVim plugin manager: junegunn/vim-plug...\n"
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  printf "=========> NOTE: run :PlugInstall first time launching nvim\n"
fi

# if [[ " ${aArgs[*]} " =~ "zsh-default" ]] || [[ $1 == "all" ]]
if [[ " ${aArgs[*]} " =~ "zsh-default" ]] 
then
  printf "=========> set zsh as default shell...\n"
  chsh -s /bin/zsh
fi

printf "========= DONE! =========\n"
