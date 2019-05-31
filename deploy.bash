#!/usr/bin/env bash

function deploy_bashrc() {
  ln -fns `find $PWD/bash/ -name "*.bash*"` ~/
  echo "[dotfiles] bashrc deployed"
}

function deploy_neovim() {
  if [[ ! -d "~/.config/nvim" ]]; then
    mkdir -p ~/.config/nvim
  fi
  mkdir -p ./neovim/plugged

  ln -fns `ls -d1 $PWD/neovim/*` ~/.config/nvim/

  echo "[dotfiles] neovim deployed"
}

function deploy_vim() {
  if [[ ! -d "~/.vim" ]]; then
    mkdir ~/.vim
  fi

  ln -fns `ls -d1 $PWD/vim/*` ~/.vim/
  echo "[dotfiles] vim deployed"
}

function deploy_all() {
  deploy_bashrc
  deploy_neovim
  deploy_vim
}

function usage () {
  echo "Usage:  $0 [options] [--]

    Options: (all with single dash)
    -a|all         Deploy everything
    -b|bash|bashrc Deploy bashrc configurations
    -n|nvim|neovim Deploy Neovim configurations
    -n|vim         Deploy Vim configurations

    -H|help        Display this message
    -V|version     Display script version"
}

#************************************************************************ {Main
__ver__="0.0.2"

while getopts ":abnvHV" opt
do
  case $opt in

  a|all) deploy_all; exit 0;;

  b|bash|bashrc) deploy_bashrc; exit 0;;

  n|nvim|neovim) deploy_neovim; exit 0;;

  v|vim) deploy_vim; exit 0;;

  H|help) usage; exit 0;;

  V|version) echo "Version $__ver__"; exit 0;;

  *) echo -e "\n  Option does not exist : $OPTARG\n"
      usage; exit 1;;

  esac
done
shift $(($OPTIND-1))
# }
