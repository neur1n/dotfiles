export def same-file [file1: path, file2: path, echo: bool = false] {
  let sha256_1 = (open --raw $file1 | hash sha256)
  let sha256_2 = (open --raw $file2 | hash sha256)
  let same = ($sha256_1 == $sha256_2)

  if ($echo or (not $same)) {
    print [[file, sha256]; [$file1, $sha256_1], [$file2, $sha256_2]]
  }

  $same
}

export def softlink [src: path, dst: path] {
  let src_abs = ($src | path expand --no-symlink)
  let dst_abs = ($dst | path expand --no-symlink)

  if not ($src_abs | path exists) {
    error make {
      msg: $"Source path does not exist: ($src_abs)"
    }
  }

  if ($dst_abs | path exists --no-symlink) {
    error make {
      msg: $"Destination already exists: ($dst_abs)"
    }
  }

  if ($nu.os-info.name == "windows") {
    let src_type = ($src_abs | path expand | path type)

    if $src_type == "dir" {
      ^CMD /C MKLINK /D $dst_abs $src_abs
    } else if $src_type == "file" {
      ^CMD /C MKLINK $dst_abs $src_abs
    } else {
      error make {
        msg: $"Unsupported source type: ($src_type)"
      }
    }
  } else {
    ln -s $src_abs $dst_abs
  }
}
