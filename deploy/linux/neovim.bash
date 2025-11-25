#!/usr/bin/env bash

src="$PWD/../../neovim"
dst="$HOME/.config/nvim"

if [[ ! -d "~/.config/nushell" ]]; then
  mkdir -p ~/.config/nushell
fi

ln -ns $src $dst

xdg-open "$dst" &
