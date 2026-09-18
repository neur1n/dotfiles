#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'Usage: %s <claude|codex|neovim|nushell|opencode|wezterm|zellij> [--dry-run] [--open]\n' "$0" >&2
}

fail() {
  printf '%s\n' "$1" >&2
  exit 1
}

add_entry() {
  local index=${#sources[@]}

  sources[index]=$1
  source_kinds[index]=$2
  destinations[index]=$3
  parent_policies[index]=$4
}

append_planned_parent() {
  local candidate=$1
  local index
  local existing

  for (( index=0; index<${#planned_parents[@]}; index++ )); do
    existing=${planned_parents[index]}
    [[ "$existing" != "$candidate" ]] || return 0
  done

  planned_parents[${#planned_parents[@]}]=$candidate
}

collect_missing_directories() {
  local current=$1
  local next
  missing_directories=()

  while [[ ! -e "$current" && ! -L "$current" ]]; do
    missing_directories[${#missing_directories[@]}]=$current
    next="$(dirname "$current")"
    [[ "$next" != "$current" ]] || return 1
    current=$next
  done

  [[ -d "$current" ]] || return 1

  if (( ${#missing_directories[@]} > 0 )); then
    [[ -w "$current" ]] || return 1
  fi
}

link_matches_source() {
  local path=$1
  local source=$2

  [[ -L "$path" && -e "$path" && "$path" -ef "$source" ]]
}

legacy_link_matches_source() {
  local path=$1
  local source=$2
  local relative_source=${source#"$repo_root"/}
  local target

  [[ "$relative_source" != "$source" && -L "$path" && ! -e "$path" ]] || return 1

  target="$(readlink "$path")" || return 1

  [[ "$target" == "$repo_root/deploy/linux/../../$relative_source" ||
     "$target" == "$repo_root/deploy/macos/../../$relative_source" ]]
}

rollback() {
  local index
  local path
  local previous_target
  local source

  for (( index=${#created_links[@]}-1; index>=0; index-- )); do
    path=${created_links[index]}
    source=${created_link_sources[index]}
    previous_target=${created_link_previous_targets[index]}

    if link_matches_source "$path" "$source"; then
      rm "$path" || printf 'Failed to roll back link: %s\n' "$path" >&2
    fi

    if [[ -n "$previous_target" && ! -e "$path" && ! -L "$path" ]]; then
      ln -s "$previous_target" "$path" || printf 'Failed to restore legacy link: %s\n' "$path" >&2
    fi
  done

  for (( index=${#created_parents[@]}-1; index>=0; index-- )); do
    path=${created_parents[index]}
    rmdir "$path" 2>/dev/null || true
  done
}

profile=""
open_after_deploy=0
dry_run=0

for arg in "$@"; do
  case "$arg" in
    --open)
      (( open_after_deploy == 0 )) || fail 'Duplicate --open argument.'
      open_after_deploy=1
      ;;
    --dry-run)
      (( dry_run == 0 )) || fail 'Duplicate --dry-run argument.'
      dry_run=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    -*)
      fail "Unknown option: $arg"
      ;;
    *)
      [[ -z "$profile" ]] || fail "Unexpected argument: $arg"
      profile=$arg
      ;;
  esac
done

if [[ -z "$profile" ]]; then
  usage
  exit 1
fi

[[ -n ${HOME:-} ]] || fail 'HOME is not set.'

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"

case "$(uname -s)" in
  Darwin)
    platform=macos
    ;;
  Linux)
    platform=linux
    ;;
  *)

  fail 'Unsupported platform. Use deploy.ps1 on Windows.'
  ;;
esac

sources=()
source_kinds=()
destinations=()
parent_policies=()
statuses=()
planned_parents=()
missing_directories=()
created_links=()
created_link_sources=()
created_link_previous_targets=()
created_parents=()
open_target=""

case "$profile" in
  claude)
    src="$repo_root/opencode/AGENTS.md"
    for parent in "$HOME/.claude" "$HOME/.tclaude"; do
      if [[ -d "$parent" ]]; then
        add_entry "$src" file "$parent/CLAUDE.md" existing
      elif [[ -e "$parent" || -L "$parent" ]]; then
        fail "Claude configuration path is not a directory: $parent"
      fi
    done
    (( ${#sources[@]} > 0 )) || fail "No Claude configuration directory exists: $HOME/.claude or $HOME/.tclaude"
    open_target=${destinations[0]}
    ;;
  codex)
    src="$repo_root/opencode/AGENTS.md"
    for parent in "$HOME/.codex" "$HOME/.tcodex"; do
      if [[ -d "$parent" ]]; then
        add_entry "$src" file "$parent/AGENTS.md" existing
      elif [[ -e "$parent" || -L "$parent" ]]; then
        fail "Codex configuration path is not a directory: $parent"
      fi
    done
    (( ${#sources[@]} > 0 )) || fail "No Codex configuration directory exists: $HOME/.codex or $HOME/.tcodex"
    open_target=${destinations[0]}
    ;;
  neovim)
    add_entry "$repo_root/neovim" directory "$HOME/.config/nvim" create
    open_target="$HOME/.config/nvim"
    ;;
  nushell)
    if [[ "$platform" == macos ]]; then
      dst="$HOME/Library/Application Support/nushell"
    else
      dst="$HOME/.config/nushell"
    fi
    add_entry "$repo_root/nushell" directory "$dst" create
    open_target=$dst
    ;;
  opencode)
    add_entry "$repo_root/opencode" directory "$HOME/.config/opencode" create
    open_target="$HOME/.config/opencode"
    ;;
  wezterm)
    add_entry "$repo_root/wezterm/.wezterm.lua" file "$HOME/.wezterm.lua" create
    add_entry "$repo_root/wezterm/.wezterm" directory "$HOME/.wezterm" create
    open_target="$HOME/.wezterm"
    ;;
  zellij)
    add_entry "$repo_root/zellij" directory "$HOME/.config/zellij" create
    open_target="$HOME/.config/zellij"
    ;;
  *)

  fail "Unknown profile: $profile"
  ;;
esac

for (( index=0; index<${#sources[@]}; index++ )); do
  src=${sources[index]}
  kind=${source_kinds[index]}
  dst=${destinations[index]}
  parent=${dst%/*}

  if [[ "$kind" == file ]]; then
    [[ -f "$src" ]] || fail "Source file does not exist: $src"
  else
    [[ -d "$src" ]] || fail "Source directory does not exist: $src"
  fi

  if [[ ${parent_policies[index]} == existing ]]; then
    [[ -d "$parent" ]] || fail "Destination parent does not exist: $parent"
  else
    collect_missing_directories "$parent" || fail "Destination parent cannot be created: $parent"
    for (( missing_index=${#missing_directories[@]}-1; missing_index>=0; missing_index-- )); do
      append_planned_parent "${missing_directories[missing_index]}"
    done
  fi

  if link_matches_source "$dst" "$src"; then
    statuses[index]=existing
  elif legacy_link_matches_source "$dst" "$src"; then
    statuses[index]=repair
    previous_targets[index]="$(readlink "$dst")"
  elif [[ -e "$dst" || -L "$dst" ]]; then
    fail "Destination conflict: $dst"
  else
    statuses[index]=create
  fi
done

if (( dry_run )); then
  for (( index=0; index<${#planned_parents[@]}; index++ )); do
    parent=${planned_parents[index]}
    printf 'Would create directory: %s\n' "$parent"
  done

  for (( index=0; index<${#sources[@]}; index++ )); do
    if [[ ${statuses[index]} == existing ]]; then
      printf 'Already deployed: %s\n' "${destinations[index]}"
    elif [[ ${statuses[index]} == repair ]]; then
      printf 'Would repair link: %s -> %s\n' "${destinations[index]}" "${sources[index]}"
    else
      printf 'Would link: %s -> %s\n' "${destinations[index]}" "${sources[index]}"
    fi
  done

  if (( open_after_deploy )); then
    printf 'Would open: %s\n' "$open_target"
  fi

  exit 0
fi

for (( parent_index=0; parent_index<${#planned_parents[@]}; parent_index++ )); do
  parent=${planned_parents[parent_index]}
  if [[ -d "$parent" ]]; then
    continue
  fi

  if [[ -e "$parent" || -L "$parent" ]]; then
    rollback
    fail "Destination parent became unavailable: $parent"
  fi

  if ! mkdir "$parent"; then
    rollback
    fail "Failed to create destination parent: $parent"
  fi

  created_parents[${#created_parents[@]}]=$parent
  printf 'Created directory: %s\n' "$parent"
done

for (( index=0; index<${#sources[@]}; index++ )); do
  src=${sources[index]}
  dst=${destinations[index]}

  if [[ ${statuses[index]} == existing ]]; then
    if link_matches_source "$dst" "$src" && [[ -e "$dst" ]]; then
      printf 'Already deployed: %s\n' "$dst"
      continue
    elif [[ -e "$dst" || -L "$dst" ]]; then
      rollback
      fail "Destination became unavailable: $dst"
    fi
  fi

  previous_target=""
  if [[ ${statuses[index]} == repair ]]; then
    if legacy_link_matches_source "$dst" "$src"; then
      previous_target=${previous_targets[index]}
      if [[ "$(readlink "$dst")" != "$previous_target" ]]; then
        rollback
        fail "Destination became unavailable: $dst"
      fi
      rm "$dst" || {
        rollback
        fail "Failed to remove legacy symbolic link: $dst"
      }
    elif link_matches_source "$dst" "$src"; then
      printf 'Already deployed: %s\n' "$dst"
      continue
    else
      rollback
      fail "Destination became unavailable: $dst"
    fi
  fi

  if [[ -e "$dst" || -L "$dst" ]]; then
    rollback
    fail "Destination became unavailable: $dst"
  fi

  created_links[${#created_links[@]}]=$dst
  created_link_sources[${#created_link_sources[@]}]=$src
  created_link_previous_targets[${#created_link_previous_targets[@]}]=$previous_target

  if [[ "$platform" == linux ]]; then
    if ! ln -sT -- "$src" "$dst"; then
      rollback
      fail "Failed to create symbolic link: $dst"
    fi
  else
    if ! ln -s "$src" "$dst"; then
      rollback
      fail "Failed to create symbolic link: $dst"
    fi
  fi

  if [[ ! -L "$dst" || "$(readlink "$dst")" != "$src" ]]; then
    nested="$dst/$(basename "$src")"
    if [[ -L "$nested" && "$(readlink "$nested")" == "$src" ]]; then
      rm "$nested" || true
    fi
    rollback
    fail "Symbolic link was not created at the expected destination: $dst"
  fi

  if [[ -n "$previous_target" ]]; then
    printf 'Repaired link: %s -> %s\n' "$dst" "$src"
  else
    printf 'Created link: %s -> %s\n' "$dst" "$src"
  fi
done

if (( open_after_deploy )); then
  if (( dry_run )); then
    printf 'Would open: %s\n' "$open_target"
  elif [[ -n ${SSH_CONNECTION:-} || -n ${SSH_CLIENT:-} || -n ${SSH_TTY:-} || -n ${MOSH_IP:-} ]]; then
    printf 'Skipping open: remote session\n' >&2
  elif [[ "$platform" == macos ]]; then
    if /bin/launchctl print "gui/$(id -u)" >/dev/null 2>&1; then
      /usr/bin/open "$open_target" || printf 'Failed to open: %s\n' "$open_target" >&2
    else
      printf 'Skipping open: no GUI session\n' >&2
    fi
  elif [[ -z ${DISPLAY:-} && -z ${WAYLAND_DISPLAY:-} ]]; then
    printf 'Skipping open: no display\n' >&2
  elif command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$open_target" || printf 'Failed to open: %s\n' "$open_target" >&2
  else
    printf 'Skipping open: xdg-open not found\n' >&2
  fi
fi
