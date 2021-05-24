#!/usr/bin/env bash

if [[ ! -d "~/.config/powershell" ]]; then
  mkdir -p ~/.config/powershell
fi

ln -ns `ls -d1 $PWD/../../pwsh/*` ~/.config/powershell/
