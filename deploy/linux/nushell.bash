#!/usr/bin/env bash

src="$PWD/../../nushell"
dst="$HOME/.config/nushell"

ln -ns $src $dst

xdg-open $dst &
