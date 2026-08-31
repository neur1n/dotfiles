# Source this file after installing the fast binary in PATH.

fast() {
  local selection_file target exit_code fast_bin
  fast_bin="${FAST_BIN:-fast}"

  if ! selection_file="$(mktemp "${TMPDIR:-/tmp}/fast-selection.XXXXXX")"; then
    return 1
  fi

  if command "$fast_bin" --select "$selection_file"; then
    exit_code=0
  else
    exit_code=$?
  fi

  if [ "$exit_code" -eq 0 ]; then
    if IFS= read -r -d '' target < "$selection_file" && [ -n "$target" ]; then
      if builtin cd -- "$target"; then
        exit_code=0
      else
        exit_code=$?
      fi
    else
      exit_code=1
    fi
  fi

  if [ "$exit_code" -eq 127 ]; then
    printf 'fast: executable "%s" not found; install it or set FAST_BIN\n' "$fast_bin" >&2
  fi

  command rm -f -- "$selection_file" || :
  return "$exit_code"
}
