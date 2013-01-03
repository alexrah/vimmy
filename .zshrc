# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dst"

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
plugins=(git osx github)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#
# export PATH to MYSQL isntalled within xampp
export PATH=$PATH:/Applications/XAMPP/xamppfiles/bin
export PATH=$PATH:~/.gem/ruby/1.8/bin
# start alias PATH
alias la="ls -lhA"
alias lr="find . -type d -maxdepth"
alias www="cd /Applications/XAMPP/xamppfiles/htdocs/"
alias psx="ps -Af"
alias cs50="cd ~/Dropbox/PROJECTS/110715_CS50/"
alias grepp="grep -A 2 -B 2 -i"
alias grepi="grep -i"
alias gitw="git whatchanged -p --color"
alias ipinfo="sh ~/.vim/command_line_tools/ipinfo.sh"
alias web2png="python ~/.vim/command_line_tools/webkit2png-0.5.py"
alias svi="sudo vi"
alias mdfindo="mdfind -onlyin ./"
alias csc="/usr/bin/find . -name '*.*' > ./cscope.files;/usr/local/bin/cscope -b;rm ./cscope.files"
alias yuic="java -jar ~/.vim/command_line_tools/yuicompressor-2.4.8pre.jar"
alias findo="find . -maxdepth 2 -type d -exec ls -ld "{}" \;"
alias top="top -o cpu"
alias duu="du -ch | grep total" # calculate folder size 
alias showip="curl -s checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"
# source aliases for GNU Linux commands,
# override standard BSD commands
source "/usr/local/Cellar/coreutils/8.12/aliases"
# Replace Color CLI for BSD (above) with GNU Linux dircolor
# dircolors colors alias, original saved in .vim/.dir_colors to synch with Git repo
eval $(dircolors -b $HOME/.dir_colors)
# ASCII art welcome screen
printf '\033[0;32m%s\033[0m\n' '         __                                     __   '
printf '\033[0;32m%s\033[0m\n' '  ____  / /_     ____ ___  __  __   ____  _____/ /_  '
printf '\033[0;32m%s\033[0m\n' ' / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \ '
printf '\033[0;32m%s\033[0m\n' '/ /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / / '
printf '\033[0;32m%s\033[0m\n' '\____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/  '
printf '\033[0;32m%s\033[0m\n' '                        /____/                       '

