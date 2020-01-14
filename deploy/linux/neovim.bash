#!/usr/bin/env bash

if [[ ! -d "~/.config/nvim" ]]; then
  mkdir -p ~/.config/nvim
fi

ln -ns `ls -d1 $PWD../../neovim/*` ~/.config/nvim/

mkdir -p ~/.config/nvim/recovery/backup
mkdir -p ~/.config/nvim/recovery/session
