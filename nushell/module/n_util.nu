use n_sys.nu


export def append-path [paths: path] {
  if (n_sys is-windows) {
    $env.Path = ($env.Path | append $paths)
    $env.Path
  } else {
    $env.PATH = ($env.PATH | append $paths)
    $env.PATH
  }
}

export def fzf-nvim [] {
  let file = (fzf | str trim)

  if not ($file | is-empty) {
    nvim  $file
  }
}

export def insert-path [paths: path] {
  if (n_sys is-windows) {
    $env.Path = ($env.Path | prepend $paths)
    $env.Path
  } else {
    $env.PATH = ($env.PATH | prepend $paths)
    $env.PATH
  }
}

export def pid [name: string] {
  (ps | where name =~ $name | get pid | get 0)
}

export def random-index [data: any] {
  (random int ..(($data | length) - 1))
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

export def softlink [src: path, dst: path] {
  if (n_sys is-windows) {
    MKLINK /J $dst $src
  } else {
    ln -s $src $dst
  }
}
