use std-rfc/kv *

const git_hard_timeout = 30sec
const git_state_key = "nu_git prompt state"

def empty-state [] {
  {
    path: "",
    request_id: null,
    job_id: null,
    phase: "none",
    info: [],
  }
}

def read-state [] {
  kv get $git_state_key | default (empty-state)
}

export-env {
  kv set $git_state_key (empty-state) | ignore
}

export def remove-submodule [path: string] {
  mv $path $"($path)_tmp"
  git submodule deinit -f -- $path
  rm -rf $".git/modules/($path)"
  git rm -f $path
}

def parse-status [stdout: string] {
  let raw = ($stdout | lines)

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
      $info.hash = (($line | split column " " | get column2).0 | str substring 0..7)
    } else if ($line | str starts-with "# branch.head") {
      $info.branch = ($line | split column " " | get column2).0
    } else if ($line | str starts-with "# branch.upstream") {
      $info.upstream = ($line | split column " " | get column2).0
    } else if ($line | str starts-with "# branch.ab") {
      let ab = ($line | split column " " col1 col2 ahead behind)
      $info.ahead = ($ab.ahead.0 | into int | math abs)
      $info.behind = ($ab.behind.0 | into int | math abs)
    } else if ($line | str starts-with "1") or ($line | str starts-with "2") {
      let staging = ($line | split column " " | get column1 | split column "" staged unstaged --collapse-empty)
      if $staging.staged.0 == "A" {
        $info.staged_added += 1
      } else if $staging.staged.0 == "D" {
        $info.staged_deleted += 1
      } else if $staging.staged.0 in ["M", "R"] {
        $info.staged_modified += 1
      }

      if $staging.unstaged.0 == "A" {
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

# Keep Git in a child job so the supervisor can enforce the hard timeout.
def spawn-status-job [cwd: string, request_id: string, on_update: closure] {
  job spawn --description $"git status ($cwd)" {
    let supervisor = (job id)
    let worker = (
      job spawn {
        let result = (
          try {
            let completed = (
              do {
                cd $cwd
                git --no-optional-locks status --porcelain=2 --branch
              } | complete)

            if $completed.exit_code == 0 {
              {
                kind: "repo",
                info: (parse-status $completed.stdout),
              }
            } else {
              {kind: "none"}
            }
          } catch {
            {kind: "error"}
          })

        try { $result | job send $supervisor } catch { null } | ignore
      })

    let received = (
      try {
        {ok: true, value: (job recv --timeout $git_hard_timeout)}
      } catch {
        {ok: false, value: null}
      })

    if $received.ok {
      commit-status $cwd $request_id $received.value $on_update
    } else {
      try { job kill $worker } catch { null } | ignore
      commit-status $cwd $request_id {kind: "timeout"} $on_update
    }
  }
}

def commit-status [cwd: string, request_id: string, result, on_update: closure] {
  mut state = (read-state)

  if (($state.path? | default "") != $cwd) or (($state.request_id? | default null) != $request_id) {
    return
  }

  if $result.kind == "repo" {
    $state.phase = "ready"
    $state.info = $result.info
    $state.job_id = null
    kv set $git_state_key $state | ignore
    try { do $on_update ($state.info) } catch { null } | ignore
  } else if $result.kind == "none" {
    $state.phase = "none"
    $state.info = []
    $state.job_id = null
    kv set $git_state_key $state | ignore
    try { do $on_update [] } catch { null } | ignore
  } else {
    $state.phase = "timeout"
    $state.info = []
    $state.job_id = null
    kv set $git_state_key $state | ignore
    try { do $on_update ({timeout: true}) } catch { null } | ignore
  }
}

export def current [] {
  let state = (read-state)
  if ($state.path? | default "") != $env.PWD {
    return []
  }

  if ($state.phase? | default "none") == "ready" {
    return $state.info
  } else if ($state.phase? | default "none") == "timeout" {
    return {timeout: true}
  }

  []
}

export def status [] {
  current
}

export def prepare [on_update: closure] {
  if (which git | is-empty) {
    return
  }

  let cwd = $env.PWD
  mut state = (read-state)

  if $state.path != $cwd {
    if not ($state.job_id | is-empty) {
      try { job kill $state.job_id } catch { null } | ignore
    }
    $state = (empty-state)
    $state.path = $cwd
  }

  if (($state.phase? | default "none") == "pending") and (not ($state.job_id | is-empty)) {
    return
  }

  let request_id = (random uuid)
  $state = {
    path: $cwd,
    request_id: $request_id,
    job_id: null,
    phase: "pending",
    info: [],
  }
  kv set $git_state_key $state | ignore

  let job_id = (spawn-status-job $cwd $request_id $on_update)
  mut latest = (read-state)
  if (($latest.path? | default "") == $cwd) and (($latest.request_id? | default null) == $request_id) and (($latest.phase? | default "none") == "pending") {
    $latest.job_id = $job_id
    kv set $git_state_key $latest | ignore
  }
}
