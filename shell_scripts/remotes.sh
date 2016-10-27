#!/bin/bash
 
repos=.git/config
gito=`grep 'gitorious' .git/config`
hub=`grep 'github' .git/config`
if [ -n "$1" ]
then
  if [ -n "$gito" ]
  then
    echo "Gitorius already mirrored."
  else
    echo '[remote "gitorious"]' >> $repos
    echo "url = git@gitorious.org:alexrah/$1.git" >> $repos
    echo "fetch = +refs/heads/*:refs/remotes/gitorious/*" >> $repos
    echo "Added $1 mirror to Gitorious."
  fi
 
  if [ -n "$hub" ]
  then
    echo "GitHub already mirrored"
  else
    echo '[remote "github"]' >> $repos
    echo "url = https://alexrah@github.com/alexrah/$1.git" >> $repos
    echo "fetch = +refs/heads/*:refs/remotes/github/*" >> $repos
    echo "Added $1 mirror to GitHub."
  fi
else
  echo "===================* HELP * ===================="
  echo ""
  echo "Plese enter the Repository Name,"
  echo "es. sh remotes.sh RepoName"
  echo ""
  echo "This script check which remote is origin and"
  echo "add GitHub or Gitorious as mirror."
  echo 'then check with "git remote show"'
fi
