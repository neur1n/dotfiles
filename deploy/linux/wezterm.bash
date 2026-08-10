#!/usr/bin/env bash
set -euo pipefail

open_after_deploy=0
if [[ $# -gt 0 ]]; then
    [[ $# -eq 1 && "$1" == "--open" ]] || {
        printf 'Usage: %s [--open]\n' "$0" >&2
        exit 1
    }
    open_after_deploy=1
fi

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/../.." && pwd)"

src="$repo_root/wezterm"
dst_lua="$HOME/.wezterm.lua"
dst_dir="$HOME/.wezterm"

[[ -f "$src/.wezterm.lua" && -d "$src/.wezterm" ]] || {
    printf 'Source does not exist: %s\n' "$src" >&2
    exit 1
}

for dst in "$dst_lua" "$dst_dir"; do
    parent="$(dirname "$dst")"
    [[ -d "$parent" ]] || {
        printf 'Destination parent does not exist: %s\n' "$parent" >&2
        exit 1
    }
    [[ ! -e "$dst" && ! -L "$dst" ]] || {
        printf 'Destination already exists: %s\n' "$dst" >&2
        exit 1
    }
done

ln -sT -- "$src/.wezterm.lua" "$dst_lua"
ln -sT -- "$src/.wezterm" "$dst_dir"

if (( open_after_deploy )); then
    if [[ -n ${SSH_CONNECTION:-} || -n ${SSH_CLIENT:-} || -n ${SSH_TTY:-} || -n ${MOSH_IP:-} ]]; then
        printf 'Skipping open: remote session\n' >&2
    elif [[ -z ${DISPLAY:-} && -z ${WAYLAND_DISPLAY:-} ]]; then
        printf 'Skipping open: no display\n' >&2
    elif command -v xdg-open >/dev/null 2>&1; then
        xdg-open "$HOME/.wezterm" || printf 'Failed to open: %s\n' "$HOME/.wezterm" >&2
    else
        printf 'Skipping open: xdg-open not found\n' >&2
    fi
fi
