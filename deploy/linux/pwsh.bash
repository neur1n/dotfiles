#!/usr/bin/env bash

if [[ ! -d "~/.config/powershell" ]]; then
  mkdir -p ~/.config/powershell
fi

ln -ns `ls -d1 $PWD/../../pwsh/*` ~/.config/powershell/

mkdir -p ~/.config/nvim/recovery/backup
mkdir -p ~/.config/nvim/recovery/session
