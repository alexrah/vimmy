#!/bin/bash

# unminimize system for interactive usage, ie, install man, etc...
unminimize

# install man, sudo, curl, nano
apt install man sudo curl

# create a user
useradd varesenews

# add passwd
passwd varesenews

# add user to sudoers
echo "varesenews ALL=(ALL:ALL) ALL" >> /etc/sudoers

# add encoding to avoid issues with Zsh prompt
echo "LANG=\"C.UTF-8\"" >> /etc/environment
source /etc/environment

# create and cd to home dir, switch to user varesenews
cd /home
mkdir varesenews
chown 1000:1000 varesenews
cd varesenews
su varesenews

# download init-4.0.sh
curl -O https://raw.githubusercontent.com/alexrah/vimmy/master/shell_scripts/init-4.0.sh

# make it executable
chmod 755 init-4.0.sh

# launch script
./init-4.0.sh all

