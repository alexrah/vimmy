# Override BSD commands with GNU Linux counterpart
# source "/usr/local/Cellar/coreutils/8.12/aliases"
# MacPorts Installer addition on 2011-03-02_at_03:29:48: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.
# start CUDA PATH 
export PATH=/usr/local/cuda/bin:$PATH
export DYLD_LIBRARY_PATH=/usr/local/cuda/lib:$DYLD_LIBRARY_PATH
# end CUDA PATH
# start DRUSH PATH
export PATH=$PATH:/Applications/XAMPP/xamppfiles/drush
export PATH=$PATH:/Applications/XAMPP/xamppfiles/bin
# end drush PATH
# start alias PATH
alias la="ls -lhA"
alias lr="find . -type d -maxdepth"
alias www="cd /Applications/XAMPP/xamppfiles/htdocs/"
alias psx="ps -Af"
alias cs50="cd ~/Dropbox/PROJECTS/110715_CS50/"
alias grepp="grep -A 2 -B 2 -i"
alias grepi="grep -i"
alias gitw="git whatchanged -p --color"
alias ipinfo="sh ~/.vim/ipinfo.sh"
alias web2png="python ~/.vim/webkit2png-0.5.py"
alias svi="sudo vi"
alias mdfindo="mdfind -onlyin ./"
alias csc="/usr/bin/find . -name '*.*' > ./cscope.files;/usr/local/bin/cscope -b;rm ./cscope.files"
alias yuic="java -jar ~/.vim/yuicompressor-2.4.8pre.jar"
alias findo="find . -maxdepth 2 -type d -exec ls -ld "{}" \;"
alias top="top -o cpu"
alias duu="du -ch | grep total"
# alias wget="curl -O"
# end alias PATH
# start editing CLI prompt
# export PS1='\u@\h:\w$';
export PS1='\[\033[0;35m\]\u@\h:\w\[\033[0m\]\n > ';
# end editing CLI prompt
# START color CLI using Yellow for Directories
# export CLICOLOR=1
# export LSCOLORS=dxfxcxdxbxegedabagacad
# eval 'dircolors ~/.dir_colors'
# END color CLI using Yellow for Directories
export PATH=$PATH:/Applications/Firefox.app/Contents/MacOS
source "/usr/local/Cellar/coreutils/8.12/aliases"
# Replace Color CLI for BSD (above) with GNU Linux dircolor
# dircolors colors alias, original saved in .vim/.dir_colors to synch with Git repo
eval $(dircolors -b $HOME/.dir_colors)
