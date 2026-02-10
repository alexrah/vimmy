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
  printf "tools : (fzf requires git) install tmux, ripgrep, fzf, bat, lsd, fd\n"
  printf "dotfiles : (requires git) install repos alexrah/vimmy & mattmc3/antidote & create symlinks\n"
  printf "lnav : install Log File Navigator (lnav) advanced log file viewer with Wordpress debug.log support\n"
  printf "node : (nvm requires dotfiles) install node stack ( nvm, node, npm, yarn )\n"
  printf "python : install python pip, python3, pip3 and neovim support\n"
  #  printf "ruby : install ruby and neovim support\n"
  printf "neovim : install or update nvim, configuration files, plugin manager\n"
  printf "example: ./init-4.0.sh all #install everything\n"
  printf "example: ./init-4.0.sh all compatible #install everything, lsd & neovim compatible versions\n"
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

if (command -v "sudo" &> /dev/null)
then
  SUDO="sudo"
else
  SUDO=""
fi

NVIM_CONFIG_PATH=~/.config
mkdir $NVIM_CONFIG_PATH
	
printf "OS: $os_type\n"
printf "================================\n"
case "$os_type" in
	"cygwin")
		printf "OS DETECTED: WINDOWS CygWin\n"
    exit
    ;;
	"Ubuntu")
		printf "OS DETECTED: UBUNTU\n"
		export PACKAGE_MANAGER="${SUDO} apt-get"
    os_family=debian
    $SUDO apt-get update
    ;;
  "Debian GNU/Linux")
		printf "OS DETECTED: DEBIAN\n"
		export PACKAGE_MANAGER="${SUDO} apt-get"
    os_family=debian
    ${SUDO} apt-get update
    ;;
	"CentOS Linux")
		printf "OS DETECTED: CENTOS\n"
		export PACKAGE_MANAGER="${SUDO} yum"
    os_family=centos
    # ${SUDO} yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
    ${SUDO} yum install https://packages.endpointdev.com/rhel/7/os/x86_64/endpoint-repo.x86_64.rpm
    ;;
	"linux-android")
		printf "OS DETECTED: TERMUX\n"
		export PACKAGE_MANAGER=pkg
    os_family=debian
    ;;
	darwin*)
		printf "OS DETECTED: MacOS\n"
		export PACKAGE_MANAGER=brew
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

    if [[ "$os_type" == "CentOS Linux" ]]
    then
      ${SUDO} cp $INSTALLERS_FOLDER/vimmy/ripgrep/centos7/rg /usr/bin/rg
    else
      $PACKAGE_MANAGER -y install ripgrep
    fi
        
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
    ${SUDO} cp bin/fzf /usr/local/bin/fzf
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
    ${SUDO} mv bat /usr/local/bin/bat
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

  if !(command -v "lsd" &> /dev/null)
  then
    printf "=========> install lsd...\n"
    if [[ "$os_family" == "centos" || $2 == "compatible" ]]
    then
      cd $INSTALLERS_FOLDER
      curl -L https://github.com/lsd-rs/lsd/releases/download/v1.1.5/lsd-v1.1.5-x86_64-unknown-linux-musl.tar.gz -o lsd.tar.gz
      tar xvzf lsd.tar.gz
      cd lsd-v1.1.5-x86_64-unknown-linux-musl
      ${SUDO} mv lsd /usr/local/bin/lsd
    else
      $PACKAGE_MANAGER install lsd
    fi
  else
    printf "=========> lsd already installed, skipping...\n"
  fi

  if !(command -v "fd" &> /dev/null)
  then
    printf "=========> install fd...\n"
    if [[ "$os_family" == "centos" ]]
    then
      cd $INSTALLERS_FOLDER
      curl -L https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-unknown-linux-musl.tar.gz -o fd.tar.gz
      tar xvzf fd.tar.gz
      cd fd-v10.2.0-x86_64-unknown-linux-musl
      ${SUDO} mv fd /usr/local/bin/fd
    else
      $PACKAGE_MANAGER install fd-find
    fi
    printf "=========> fd binary is called fdfind, check if fd is available and then ln -s \$(which fdfind) /usr/local/bin/fd\n"
  else
    printf "=========> fd already installed, skipping...\n"
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
  if !(test -d antidote)
  then
    printf "=========> clone mattmc3/antidote.git in antidote folder...\n"
    git clone --depth=1 https://github.com/mattmc3/antidote.git antidote
  else
    printf "=========> folder antidote already exists, skipping...\n"
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
    ${SUDO} mv lnav-0.12.2/lnav /usr/local/bin/lnav
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

# PYTHON3 SUPPORT
if [[ " ${aArgs[*]} " =~ "python" ]]
then
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
	  ${SUDO} python3 get-pip3.py
  else
    printf "=========> pip3 already installed, skipping...\n"
  fi


  printf "Python: install virtualenv & create .virtualenvs...\n"
  printf "================================\n"
  mkdir -p ~/.virtualenvs/
  python3 -m venv ~/.virtualenvs/neovim-python3 # create a new venv
  cd ~/.virtualenvs/neovim-python3
  source bin/activate
  pip install pynvim jupyter_client cairosvg plotly kaleido pnglatex pyperclip
  deactivate
fi


if [[ " ${aArgs[*]} " =~ "neovim" ]] || [[ $1 == "all" ]]
then

  if !(command -v "nvim" &> /dev/null)
  then
    printf "=========> install neovim...\n"
    
    if [[ $os_family == "centos" || $2 == "compatible" ]]
    then
      # install best-efforts build made with glibc 2.17
      curl -L -o nvim.appimage https://github.com/neovim/neovim-releases/releases/download/v0.11.3/nvim-linux-x86_64.appimage
    else
      curl -L -o nvim.appimage https://github.com/neovim/neovim/releases/latest/download/NVIM-linux-x86_64.appimage
    fi

    chmod 755 nvim.appimage
    ./nvim.appimage --appimage-extract
    ${SUDO} mv squashfs-root /usr/local/bin/squashfs-root-nvim
    ${SUDO} ln -s /usr/local/bin/squashfs-root-nvim/usr/bin/nvim /usr/local/bin/nvim
  fi

  printf "=========> install symlinks: nvim in "$NVIM_CONFIG_PATH"\n"
  ln -s $INSTALLERS_FOLDER/vimmy/nvim $NVIM_CONFIG_PATH/nvim
  mkdir -p ~/.vim_runtime/undodir

  printf "=========> SEE: NeoVide.md instructions for NeoVide GUI installation\n"

fi

# if [[ " ${aArgs[*]} " =~ "zsh-default" ]] || [[ $1 == "all" ]]
if [[ " ${aArgs[*]} " =~ "zsh-default" ]] 
then
  printf "=========> set zsh as default shell...\n"
  chsh -s /bin/zsh
fi

printf "========= DONE! =========\n"
