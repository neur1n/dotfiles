#!/usr/bin/env bash

src="$PWD/../../zellij"
dst="$HOME/.config/zellij"

ln -ns $src $dst

xdg-open "$dst" &
