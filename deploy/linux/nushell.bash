#!/usr/bin/env bash
#
if [[ ! -d "~/.config/nushell" ]]; then
  mkdir -p ~/.config/nushell
fi

ln -ns `ls -d1 $PWD/../../nushell/*` ~/.config/nushell/
