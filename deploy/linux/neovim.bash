#!/usr/bin/env bash

src="$PWD"
dst="$HOME/.config/nvim"

if [ -d "$dst" ]; then
  rm -rf "$dst"
fi

ln -ns "$src/../../neovim" "$dst"

xdg-open "$dst" &
