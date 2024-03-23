#!/usr/bin/env bash

src="$PWD"
dst="$HOME/.config/nvim"

if [ -d "$dst" ]; then
  rm -rf "$dst"
fi

if [[ ! -d "~/.config/nvim" ]]; then
  mkdir -p ~/.config/nvim
fi

ln -ns "$src/../../neovim" "$dst"

mkdir -p "$dst/recovery/backup"
mkdir -p "$dst/recovery/session"

xdg-open "$dst" &
