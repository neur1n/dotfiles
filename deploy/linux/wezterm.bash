#!/usr/bin/env bash

src="$PWD/../../wezterm"
dst="$HOME"

ln -ns $src/.wezterm.lua $dst/.wezterm.lua
ln -ns $src/.wezterm $dst/.wezterm
