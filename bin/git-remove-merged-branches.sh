#!/bin/bash

#Source
  #http://rob.by/2013/remove-merged-branches-from-git/

#Modified by: Eduardo de Oliveira Hernandes - eduardodeoh@gmail.com

function remove_merged_branches {
  current_branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  if [ "$current_branch" != "master" -o "$current_branch" != "develop" ]; then
    echo "WARNING: You are on branch $current_branch, NOT master."
  fi
  echo "Fetching merged branches..."
  remote_branches=$(git branch -r --merged | grep -v '/master$' | grep -v '/develop$' | grep -v "/$current_branch$")
  local_branches=$(git branch --merged | grep -v 'master$' | grep -v 'develop$' | grep -v "$current_branch$")
  if [ -z "$remote_branches" ] && [ -z "$local_branches" ]; then
    echo "No existing branches have been merged into $current_branch."
  else
    echo "This will remove the following branches:"
    if [ -n "$remote_branches" ]; then
      echo "$remote_branches"
    fi
    if [ -n "$local_branches" ]; then
      echo "$local_branches"
    fi
    read -p "Continue? (y/n): " -n 1 choice
    echo
    if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
      # Remove remote branchesi
      git push origin `git branch -r --merged | grep -v '/master$' | grep -v '/develop$' | grep -v "/$current_branch$" | sed 's/origin\//:/g' | tr -d '\n'`
      # Remove local branches
      git branch -d `git branch --merged | grep -v 'master$' | grep -v 'develop$' | grep -v "$current_branch$" | sed 's/origin\///g' | tr -d '\n'`
    else
      echo "No branches removed."
    fi
  fi
}

remove_merged_branches