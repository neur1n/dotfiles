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

src="$repo_root/zellij"
dst="$HOME/.config/zellij"

[[ -e "$src" ]] || {
    printf 'Source does not exist: %s\n' "$src" >&2
    exit 1
}

parent="$(dirname "$dst")"
[[ -d "$parent" ]] || {
    printf 'Destination parent does not exist: %s\n' "$parent" >&2
    exit 1
}

[[ ! -e "$dst" && ! -L "$dst" ]] || {
    printf 'Destination already exists: %s\n' "$dst" >&2
    exit 1
}

ln -s "$src" "$dst"

if (( open_after_deploy )); then
    if [[ -n ${SSH_CONNECTION:-} || -n ${SSH_CLIENT:-} || -n ${SSH_TTY:-} ]]; then
        printf 'Skipping open: SSH session\n' >&2
    elif /bin/launchctl print "gui/$(id -u)" >/dev/null 2>&1; then
        /usr/bin/open "$dst" || printf 'Failed to open: %s\n' "$dst" >&2
    else
        printf 'Skipping open: no GUI session\n' >&2
    fi
fi
