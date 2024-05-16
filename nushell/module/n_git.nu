export def in-repo [] {
  if (which git) == "" {
    print "Git is not found."
  } else {
    return ((do {git rev-parse --is-inside-work-tree} | complete | get stdout) =~ "true")
  }
}

export def status [] {
  if not (in-repo) {
    return []
  }

  let raw = (git --no-optional-locks status --porcelain=2 --branch | lines)

  mut info = {
    hash: "",
    branch: "",
    upstream: "",
    ahead: 0,
    behind: 0,
    staged_added: 0,
    staged_deleted: 0,
    staged_modified: 0,
    unstaged_added: 0,
    unstaged_deleted: 0,
    unstaged_modified: 0,
    untracked: 0,
    conflict: 0,
  }

  for line in $raw {
    if ($line | str starts-with "# branch.oid") {
      $info.hash = (($line | split column " " | get column3).0 | str substring 0..7)
    } else if ($line | str starts-with "# branch.head") {
      $info.branch = ($line | split column " " | get column3).0
    } else if ($line | str starts-with "# branch.upstream") {
      $info.upstream = ($line | split column " " | get column3).0
    } else if ($line | str starts-with "# branch.ab") {
      let ab = ($line | split column " " col1 col2 ahead behind)
      $info.ahead = ($ab.ahead.0 | into int | math abs)
      $info.behind = ($ab.behind.0 | into int | math abs)
    } else if ($line | str starts-with "1") or ($line | str starts-with "2") {
      let staging = ($line | split column " " | get column2 | split column "" staged unstaged --collapse-empty)
      if $staging.staged.0 == "A" {
        $info.staged_added += 1
      } else if $staging.staged.0 == "D" {
        $info.staged_deleted += 1
      } else if $staging.staged.0 in ["M", "R"] {
        $info.staged_modified += 1
      } else if $staging.unstaged.0 == "A" {
        $info.unstaged_added += 1
      } else if $staging.unstaged.0 == "D" {
        $info.unstaged_deleted += 1
      } else if $staging.unstaged.0 in ["M", "R"] {
        $info.unstaged_modified += 1
      }
    } else if ($line | str starts-with "?") {
      $info.untracked += 1
    } else if ($line | str starts-with "u") {
      $info.conflict += 1
    }
  }

  return $info
}

export def remove-submodule [path: string] {
  mv $path $"($path)_tmp"
  git submodule deinit -f -- $path
  rm -rf $".git/modules/($path)"
  git rm -f $path
}
