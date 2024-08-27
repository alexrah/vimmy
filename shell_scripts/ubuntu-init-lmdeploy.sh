#!/usr/bin/sh

# fix locales
apt-get -y install locales
echo "en_US.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen
locale-gen
export LC_ALL=en_US.UTF-8

# install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /root/.zshrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
sudo apt-get install build-essential

# install pyenv to manage multiple python versions
brew install pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc

# symlink python3 to python
ln -s /usr/bin/python3 /usr/local/bin/python

# Install PDM (Python Package Manager)
apt install python3.10-venv
curl -sSL https://pdm-project.org/install-pdm.py | python3 -

# install LMDeploy
cd ~
mkdir lmdeploy
cd lmdeploy
pdm init
pdm add lmdeploy