## Install tools, environment, configurations for UNIX-like shell

* log into shell using an account having sudo capabilities

* download init script

```
curl -OL https://raw.githubusercontent.com/alexrah/vimmy/master/shell_scripts/init-4.0.sh

chmod 755 init-4.0.sh

./init-4.0.sh help
```

*  show a list of options 
*  in case of clean system run:

```
./init-4.0.sh all
```

### help's option output:
```
========================
IMPORTANT: user (dont use root) needs to be inside sudoers to be able to install packages
all : install everything if not already installed
help : show this message
Please provide one of the following option or comma separated list of options to install specific packages:
git : install only git
zsh : install only zsh
zsh-default : set zsh as default shell
tools : (fzf requires git) install tmux, ripgrep, fzf, bat
dotfiles : (requires git) install repos alexrah/vimmy & alexrah/oh-my-zsh & create symlinks
node : (nvm requires dotfiles) install node stack ( nvm, node, npm, yarn )
python : install python pip, python3, pip3 and neovim support
neovim : install or update nvim, configuration files, plugin manager
example: ./init-4.0.sh all #install everything
example: ./init-4.0.sh help #show this message
example: ./init-4.0.sh node #install node stack ( nvm, node, npm, yarn )
example: ./init-4.0.sh nvim,dotfiles #install nvim & install dotfiles
========================
```