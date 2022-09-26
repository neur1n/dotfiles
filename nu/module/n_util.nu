use n_os.nu


export def append-path [paths: path] {
  if (n_os is-windows) {
    let-env Path = ($env.Path | append $paths)
    $env.Path
  } else {
    let-env PATH = ($env.PATH | append $paths)
    $env.PATH
  }
}

export def insert-path [paths: path] {
  if (n_os is-windows) {
    let-env Path = ($env.Path | prepend $paths)
    $env.Path
  } else {
    let-env PATH = ($env.PATH | prepend $paths)
    $env.PATH
  }
}

export def random-index [data: any] {
  (random integer ..(($data | length) - 1))
}

export def same-file [file1: path, file2: path, echo: bool = false] {
  let md5_1 = (open $file1 | hash md5)
  let md5_2 = (open $file2 | hash md5)
  let sha256_1 = (open $file1 | hash sha256)
  let sha256_2 = (open $file2 | hash sha256)

  if ($md5_1 == $md5_2 && $sha256_1 == $sha256_2) {
    if ($echo) {
      echo [[file, md5, sha256]; [$file1, $md5_1, $sha256_1], [$file2, $md5_2, $sha256_2]]
    }
    true
  } else {
    echo [[file, md5, sha256]; [$file1, $md5_1, $sha256_1], [$file2, $md5_2, $sha256_2]]
    false
  }
}
