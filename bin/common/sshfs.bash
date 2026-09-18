#!/usr/bin/env bash
# Run sshfs under a foreground supervisor and unmount the local path on exit.
# Intended for LaunchManager/launchd User Agents that need mount cleanup when
# the agent stops.
#
# Usage:
#   ./sshfs.bash <remote> <local>
#   ./sshfs.bash --help
#
# Example:
#   ./sshfs.bash user@host:/remote/path /local/path
#
# Supported platforms: macOS with macFUSE and Linux with FUSE.
# SSHFS is resolved from PATH first, then from common absolute paths. The
# LaunchManager environment must also let SSHFS find the ssh command.
# Authentication must work without an interactive terminal.
#
# The wrapper keeps SSHFS in the foreground, forwards HUP/INT/TERM to it, and
# performs a best-effort unmount when it exits. SIGKILL, crashes, power loss,
# and similar abrupt termination cannot be handled by this script.
# There is no internal shutdown timeout. A supervising manager may eventually
# force-kill a process that does not exit, which can leave a stale mount.
#
# SSHFS is run with -o reconnect. Temporary connection failures keep the
# process and mount alive; open handles may need to be reopened after a
# reconnect, and in-flight writes may be lost.

set -uo pipefail

SCRIPT_NAME="${0##*/}"

usage() {
  printf 'Usage: %s <remote> <local>\n' "$0"
  printf '       %s --help\n' "$0"
  printf '\n'
  printf 'Mount an SSHFS remote and unmount it when the wrapper exits.\n'
  printf 'Example: %s user@host:/remote/path /local/path\n' "$0"
}

if [[ "$#" -eq 1 && ( "$1" == "-h" || "$1" == "--help" ) ]]; then
  usage
  exit 0
fi

if [[ "$#" -ne 2 ]]; then
  usage >&2
  exit 2
fi

REMOTE="$1"
LOCAL="$2"
OS="$(uname -s)"

case "$OS" in
  Darwin|Linux)
    ;;
  *)
    printf '%s: unsupported OS: %s\n' "$SCRIPT_NAME" "$OS" >&2
    exit 1
    ;;
esac

# launchd's PATH is often very limited, so check common absolute paths too.
if command -v sshfs >/dev/null 2>&1; then
  SSHFS="$(command -v sshfs)"
elif [[ -x /opt/homebrew/bin/sshfs ]]; then
  SSHFS=/opt/homebrew/bin/sshfs
elif [[ -x /usr/local/bin/sshfs ]]; then
  SSHFS=/usr/local/bin/sshfs
elif [[ -x /usr/bin/sshfs ]]; then
  SSHFS=/usr/bin/sshfs
else
  printf '%s: sshfs not found in PATH or common locations\n' "$SCRIPT_NAME" >&2
  exit 127
fi

mkdir -p "$LOCAL" || exit 1

is_mounted() {
  case "$OS" in
    Darwin)
      /sbin/mount | grep -F " on $LOCAL (" >/dev/null 2>&1
      ;;
    Linux)
      command -v mountpoint >/dev/null 2>&1 && mountpoint -q "$LOCAL"
      ;;
    *)
      return 1
      ;;
  esac
}

# Refuse to touch an already-mounted path.
#
# This prevents:
#   existing filesystem at LOCAL
#   -> new sshfs fails
#   -> cleanup accidentally unmounts the old filesystem
if is_mounted; then
  printf '%s: already mounted: %s\n' "$SCRIPT_NAME" "$LOCAL" >&2
  exit 1
fi

cleanup() {
  local exit_status=$?

  case "$OS" in
    Darwin)
      /sbin/umount "$LOCAL" >/dev/null 2>&1 ||
      /usr/sbin/diskutil unmount force "$LOCAL" >/dev/null 2>&1 ||
      true
      ;;

    Linux)
      if command -v fusermount3 >/dev/null 2>&1; then
        fusermount3 -u "$LOCAL" >/dev/null 2>&1 ||
        fusermount3 -uz "$LOCAL" >/dev/null 2>&1 ||
        true
      elif command -v fusermount >/dev/null 2>&1; then
        fusermount -u "$LOCAL" >/dev/null 2>&1 ||
        fusermount -uz "$LOCAL" >/dev/null 2>&1 ||
        true
      else
        umount "$LOCAL" >/dev/null 2>&1 || true
      fi
      ;;
  esac

  if is_mounted; then
    printf '%s: mount still present after cleanup: %s\n' \
      "$SCRIPT_NAME" "$LOCAL" >&2
  fi

  return "$exit_status"
}

# Common SSHFS arguments.
set -- \
  "$REMOTE" \
  "$LOCAL" \
  -f \
  -o auto_cache \
  -o follow_symlinks \
  -o reconnect \
  -o ServerAliveInterval=15 \
  -o ServerAliveCountMax=3

# macFUSE-only option.
if [[ "$OS" == "Darwin" ]]; then
  set -- "$@" -o noappledouble
fi

SSHFS_PID=""
STOP_REQUESTED=0
WAIT_INTERRUPTED=0

forward_signal() {
  STOP_REQUESTED=1
  WAIT_INTERRUPTED=1

  if [[ -n "$SSHFS_PID" ]]; then
    kill -TERM "$SSHFS_PID" >/dev/null 2>&1 || true
  fi
}

trap forward_signal HUP INT TERM
trap cleanup EXIT

"$SSHFS" "$@" &
SSHFS_PID=$!

if [[ "$STOP_REQUESTED" -eq 1 ]]; then
  kill -TERM "$SSHFS_PID" >/dev/null 2>&1 || true
fi

while :; do
  WAIT_INTERRUPTED=0
  wait "$SSHFS_PID"
  STATUS=$?

  # A trapped signal can interrupt wait before SSHFS has exited. Wait again
  # so the wrapper never intentionally abandons its direct child.
  if [[ "$WAIT_INTERRUPTED" -eq 1 && "$STATUS" -gt 128 ]]; then
    continue
  fi

  break
done

SSHFS_PID=""

exit "$STATUS"
