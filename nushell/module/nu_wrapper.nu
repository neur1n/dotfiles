export def --wrapped nvim [
  --fuzzy (-f) # Select a file with fzf; cannot be combined with other arguments.
  ...args      # Arguments passed to Neovim when --fuzzy is not set.
] {
  if $fuzzy and ($args | is-not-empty) {
    error make {
      msg: "--fuzzy cannot be combined with other Neovim arguments"
    }
  }

  let nvim_args = if $fuzzy {
    let result = (^fzf --no-multi --print0 | complete)

    if $result.exit_code in [1, 130] {
      return
    }

    if $result.exit_code != 0 {
      error make {
        msg: $"fzf failed with exit code ($result.exit_code)"
        help: ($result.stderr | str trim)
      }
    }

    let file = ($result.stdout | str trim --right --char (char nul))
    if ($file | is-empty) {
      return
    }

    ["--", $file]
  } else {
    $args
  }

  ^nvim ...$nvim_args
}

export def --wrapped tar [...args] {
  if $nu.os-info.name == "macos" {
    with-env {
      COPYFILE_DISABLE: "1"
    } {
      ^tar --no-acls --no-fflags --no-mac-metadata --no-xattrs ...$args
    }
  } else {
    ^tar ...$args
  }
}
