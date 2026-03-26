#!/bin/bash

printf "Removing neovim legacy...\n"
printf "================================\n"
printf "Removing configuration legacy...\n"
rm -r ~/.config/nvim
rm -r ~/.local/share/nvim
rm -r ~/.local/state/nvim
rm -r ~/.cache/nvim
printf "Removing neovim artifacts...\n"
rm -r ~/.dotfiles/squashfs-root
rm ~/.dotfiles/nvim.appimage
printf "Removing neovim app...\n"
rm /usr/local/bin/nvim
rm /usr/local/bin/squashfs-root-nvim
