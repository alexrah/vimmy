INSTALLERS_FOLDER=~/.dotfiles
# Path to your oh-my-zsh configuration.
ZSH=$INSTALLERS_FOLDER/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="dst"
# ZSH_THEME="kphoen"
ZSH_THEME="dstkph"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github colored-man-pages bower gem web-search yum history-substring-search zsh-autosuggestions zsh-syntax-highlighting nvm kubectl helm wp-cli)

# Oh-My-Zsh NVM plugin config
zstyle ':omz:plugins:nvm' autoload yes

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#
# Set Vi as default bash mode
set -o vi
#
# export PATH to MYSQL isntalled within xampp
# export PATH=$PATH:/Applications/XAMPP/xamppfiles/bin
# export PATH=$PATH:~/.gem/ruby/1.8/bin
# export PATH=$PATH:./node/
export PATH=$PATH:~/.local/bin
# start alias PATH
export EDITOR=nvim
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'
export DOTFILES=~/.dotfiles
alias wpscan="~/wpscan/wpscan.rb"
alias ls="ls --color=auto"
alias la="ls -lhA"
alias lat="ls -lhA --sort=t"
alias lr="find . -type d -maxdepth"
alias psx="ps -Af"
alias psxg="ps -Af | grep"
alias cs50="cd ~/Insync/alexrah@gmail.com/PROJECTS/110715_CS50/"
alias grepp="grep -A 2 -B 2 -i"
alias grepi="grep -i"
alias gitw="git whatchanged -p --color"
alias ipinfo="sh $DOTFILES/vimmy/command_line_tools/ipinfo.sh"
# alias web2png="python ~/.vim/command_line_tools/webkit2png-0.5.py"
alias web2png="$DOTFILES/vimmy/command_line_tools/webkit2png-0.8.py"
alias svi="sudo vim"
alias mdfindo="mdfind -onlyin ./"
alias csc="/usr/bin/find . -name '*.*' > ./cscope.files;/usr/bin/cscope -b;rm ./cscope.files"
alias yuic="java -jar $DOTFILES/vimmy/command_line_tools/yuicompressor-2.4.8pre.jar"
alias findo="find . -maxdepth 2 -type d -exec ls -ld "{}" \;"
alias folder-size="du -ch | grep total" # calculate folder size 
alias top-ten-global="du -a / | sort -n -r | head -n 10" # calculate top 10 biggest folder/files on disk
alias top-ten-local="du -a ./ | sort -n -r | head -n 10" # calculate top 10 biggest folder/files in working directory
alias disk-size="df -H" # display all disks size
alias showip="curl -s checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"
alias tmux-persistence="$DOTFILES/vimmy/command_line_tools/tmux-persistence/tmux-persist.rb"
alias tmux-session="$DOTFILES/vimmy/command_line_tools/tmux-persistence/tmux-session"
alias speedtest="$DOTFILES/vimmy/command_line_tools/speedtest_cli.py"
alias speedtest3="$DOTFILES/vimmy/command_line_tools/speedtest_cli3.py"
alias netspeed="$DOTFILES/vimmy/command_line_tools/netspeed.sh"
# reverse engineer Dockerfile from Docker image
alias whaler="docker run -v /var/run/docker.sock:/var/run/docker.sock --rm alpine/dfimage"
# alias composer="php /usr/local/bin/composer.phar"

# Git aliases - ref: https://githowto.com/aliases
alias gs='git status'
alias ga='git add'
alias gb='git branch'
alias gca='git commit -a -m'
alias gc='git commit -m'
alias gd='git diff --submodule=log'
alias gdo='gd | bat'
alias gt='git checkout'
alias gf='git fetch'
alias gfa='git fetch --all'
alias gk='gitk --all&'
alias gx='gitx --all'
alias gm='git submodule foreach git checkout master; git submodule foreach git pull origin master'
alias gl='git log --graph'
alias gla='git log --graph --all'
alias glt='git log --tags --no-walk'

# Fuzzy search preview files
alias fp='rg --files | fzf --preview "bat --color=always --decorations=always {}"'

alias phps='open -na "PhpStorm.app" --args "$@"'
alias pyc='open -na "PyCharm CE.app" --args "$@"'

# Git Repo Cleaner - @see https://rtyley.github.io/bfg-repo-cleaner/
alias bfg='java -jar $DOTFILES/bfg.jar'

# Auto-completion (worsks with ** + TAB)
# ---------------
source ~/.dotfiles/fzf/shell/completion.zsh

# source aliases for GNU Linux commands,
# override standard BSD commands
# source "/usr/local/Cellar/coreutils/8.12/aliases"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
# Add support for GNU Linux dircolor
# dircolors colors alias, original saved in .vim/.dir_colors to synch with Git repo
eval $(dircolors -b $HOME/.dir_colors)
# ASCII art welcome screen
# printf '\033[0;34m%s\033[0m\n' '                      88                                    88                     '
# printf '\033[0;34m%s\033[0m\n' '                      88               aa                   ""                     '
# printf '\033[0;34m%s\033[0m\n' '                      88               88                                          '
# printf '\033[0;34m%s\033[0m\n' '888888888  ,adPPYba,  88,dPPYba,   aaaa88aaaa  8b       d8  88  88,dPYba,,adPYba,  '
# printf '\033[0;34m%s\033[0m\n' '     a8P"  I8[    ""  88P"    "8a  """"88""""  `8b     d8/  88  88P`   "88"    "8a '
# printf '\033[0;34m%s\033[0m\n' '  ,d8P`     `"Y8ba,   88       88      88       `8b   d8/   88  88      88      88 '
# printf '\033[0;34m%s\033[0m\n' ',d8"       aa    ]8I  88       88      ""        `8b,d8/    88  88      88      88 '
# printf '\033[0;35m%s\033[0m\n' '888888888  `"YbbdP"`  88       88                  "8"      88  88      88      88 '
# printf '\033[0;36m%s\033[0m\n' '                           88                                                       '  
# printf '\033[0;36m%s\033[0m\n' '      aa                   ""    ,d         aa                                      ' 
# printf '\033[0;36m%s\033[0m\n' '      88                         88         88                                      '  
# printf '\033[0;36m%s\033[0m\n' '  aaaa88aaaa   ,adPPYb,d8  88  MM88MMM  aaaa88aaaa  8b       d8   ,adPPYba,         '  
# printf '\033[0;36m%s\033[0m\n' '  """"88""""  a8"    `Y88  88    88     """"88""""  `8b     d8`  a8"     "8a        '  
# printf '\033[0;36m%s\033[0m\n' '      88      8b       88  88    88         88       `8b   d8`   8b       d8        '  
# printf '\033[0;36m%s\033[0m\n' '      ""      "8a,   ,d88  88    88,        ""        `8b,d8"    "8a,   ,a8"        ' 
# printf '\033[0;36m%s\033[0m\n' '               `"YbbdP"Y8  88    "Y888                  Y88/      `"YbbdP"`         '  
# printf '\033[0;36m%s\033[0m\n' '               aa,    ,88                               d8`                         '  
# printf '\033[0;36m%s\033[0m\n' '                "Y8bbdP"                               d8`                          '  

# CREATE a conditions to deal whith OS and the 'open' command
case "$OSTYPE" in
   cygwin)
      alias open="cmd /c start";;
   linux)
      alias start="gnome-open"
      alias open="gnome-open";;
   darwin*)
      alias start="open"
      export LC_ALL=en_US.UTF-8
      export LANG=en_US.UTF-8;;
  esac


# PYTHON
# make neovim works under python virtual_env
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

if command -v pdm &> /dev/null
then
  eval "$(pdm --pep582)"
fi

#HOST ASCII ART
# to generate it, got to: https://patorjk.com/software/taag/#p=display&c=echo&f=Big&t=MacBookPro
HOSTASCIIARTFILE="/etc/host.ascii"
if test -f $HOSTASCIIARTFILE
then
  source $HOSTASCIIARTFILE
fi

#KUBERNETES
export KUBECONFIG=${HOME}/.kube/docker.config.yml:${HOME}/.kube/pct.kubeconfig.yml:${HOME}/.kube/config:${HOME}/.kube/jrliban.kubeconfig.yml:${HOME}/.kube/minikube.kubeconfig.yml

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
