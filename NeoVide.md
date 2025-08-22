# NeoVide (NeoVim GUI Wrapper)

@see [https://neovide.dev/](https://neovide.dev/)

# Configuration

## Node

for `Typescript` projects, a running tsserver is required.

To run it, node must be available in $PATH even outside an interactive shell.

Since I'm using NVM (Node Version Manager) which is loaded dynamically in ZSH,
node is not available outside shell, therefore NeoVide can't find it.

to fix this, launch Neovide from a shell (see the CLI support section below)

~~to fix this, create a `.zprofile` in the $HOME directory to initialize NVM even
outside an interactive shell.~~

the following snippet **WON'T WORK** because conflicts with NVM logic to auto-switch node version based 
```bash
# ~/.zprofile

# See https://github.com/nvm-sh/nvm#installation-and-update
if [[ -z "$NVM_DIR" ]]; then
  if [[ -d "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
  elif [[ -d "${XDG_CONFIG_HOME:-$HOME/.config}/nvm" ]]; then
    export NVM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvm"
  elif (( $+commands[brew] )); then
    NVM_HOMEBREW="${NVM_HOMEBREW:-${HOMEBREW_PREFIX:-$(brew --prefix)}/opt/nvm}"
    if [[ -d "$NVM_HOMEBREW" ]]; then
      export NVM_DIR="$NVM_HOMEBREW"
    fi
  fi
fi

source "$NVM_DIR/nvm.sh"

```

## CLI support

add a Neovide's binary alias to $PATH to be able to launch it from CLI

```bash
ln -s /Applications/Neovide.app/Contents/MacOS/neovide /usr/local/bin/neovide

```
