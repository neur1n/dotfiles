#!/usr/bin/env bash

src="$PWD/../../opencode"
dst="$HOME/.config/opencode"

ln -ns $src $dst

xdg-open "$dst" &
