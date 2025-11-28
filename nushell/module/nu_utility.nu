export def neovim [
    --fuzzy  (-f),
    --listen (-l),
    file?: path] {
  if not ($fuzzy or $listen) {
    match $file {
      null => {
        run-external nvim
      }
      _ => {
        run-external nvim $file
      }
    }

    return
  }

  mut cmd = ["nvim"]

  if $listen {
    let socket = (
      if ($nu.os-info.name == "windows") {
        "localhost:9527"
      } else {
        "/tmp/nvim.sock.9527"
      }
    )

    $cmd = ($cmd | append "--listen" | append $socket)
  }

  if $fuzzy {
    let selected = (fzf | str trim)
    if not ($selected | is-empty) {
      $cmd = ($cmd | append $selected)
    } else if not $listen {
      return
    }
  } else if not ($file | is-empty) {
    $cmd = ($cmd | append $file)
  }

  run-external ...$cmd
}

export def pid [name: string] {
  (ps | where name =~ $name | get pid | get 0)
}

export def repeat [times: int, command: closure] {
  mut i = 0

  loop {
    if ($i < $times) {
      do $command
      $i = $i + 1
    } else {
      break
    }
  }
}

export def same-file [file1: path, file2: path, echo: bool = false] {
  let md5_1 = (open $file1 | hash md5)
  let md5_2 = (open $file2 | hash md5)
  let sha256_1 = (open $file1 | hash sha256)
  let sha256_2 = (open $file2 | hash sha256)

  if ($md5_1 == $md5_2 and $sha256_1 == $sha256_2) {
    if ($echo) {
      print [[file, md5, sha256]; [$file1, $md5_1, $sha256_1], [$file2, $md5_2, $sha256_2]]
    }
    true
  } else {
    print [[file, md5, sha256]; [$file1, $md5_1, $sha256_1], [$file2, $md5_2, $sha256_2]]
    false
  }
}

export def set-wezterm-tabe-title [] {
  use nu_system.nu
  run-external wezterm cli set-tab-title $"(whoami)@(nu_system ip)"
}

export def softlink [src: path, dst: path] {
  if ($nu.os-info.name == "windows") {
    MKLINK /J $dst $src
  } else {
    ln -s $src $dst
  }
}
