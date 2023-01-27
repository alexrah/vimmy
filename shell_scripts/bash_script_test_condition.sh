#!/bin/bash


if ! test -n "$1"
then
  printf "not args\n"
else
  printf "args is $1\n"
fi

if command -v git &> /dev/null
then
	printf "git installed\n"
else
	printf "git could not be found\n"
fi

if test -f ~/.config/nvim/init.vim  &> /dev/null
then
	printf "init.vim installed\n"
else
	printf "init.vim could not be found\n"
fi

if test -d ~/.config/nvim/ &> /dev/null
then
	printf "nvim folder installed\n"
else
	printf " nvim folder could not be found\n"
fi

printf "enter passwd:\n"
read passwd
if [[ $passwd == "alex" || ! -n $passwd ]]
then
  printf "wrong passwd\n"
else
  printf "OK!\n"
fi


