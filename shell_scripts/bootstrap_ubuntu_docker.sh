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

