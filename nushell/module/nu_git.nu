use std-rfc/kv *

const git_prompt_timeout = 500ms
const git_hard_timeout = 30sec
const git_job_tag = 9527
const git_state_key = "nu_git prompt state"

export-env {
  kv set $git_state_key {
    path: "",
    job_id: null,
    stale: false,
    info: [],
  } | ignore
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

# Keep Git in a child job so the supervisor can enforce the timeout.
def spawn-status-job [cwd: string] {
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

        $result | job send $supervisor
      })

    let received = (
      try {
        {ok: true, value: (job recv --timeout $git_hard_timeout)}
      } catch {
        {ok: false, value: null}
      })

    if $received.ok {
      {
        source: "nu_git",
        kind: "result",
        path: $cwd,
        job_id: $supervisor,
        result: $received.value,
      } | job send 0 --tag $git_job_tag
    } else {
      try { job kill $worker } catch { null } | ignore

      {
        source: "nu_git",
        kind: "hard-timeout",
        path: $cwd,
        job_id: $supervisor,
      } | job send 0 --tag $git_job_tag
    }
  }
}

def apply-status-message [state message cwd] {
  mut next = $state

  if ($message.source? | default "") != "nu_git" {
    return $next
  }

  if ($message.path? | default "") != $cwd {
    return $next
  }

  if ($next.job_id | is-empty) or $message.job_id != $next.job_id {
    return $next
  }

  if $message.kind == "result" and $message.result.kind == "repo" {
    $next.info = $message.result.info
    $next.stale = false
  } else if $message.kind == "result" and $message.result.kind == "none" {
    $next.info = []
    $next.stale = false
  } else {
    $next.stale = not ($next.info | is-empty)
  }

  $next.job_id = null
  $next
}

def wait-status-message [cwd job_id timeout] {
  let deadline = ((date now) + $timeout)
  mut messages = []

  loop {
    let remaining = ($deadline - (date now))
    if $remaining <= 0sec {
      break
    }

    let candidate = (
      try {
        job recv --tag $git_job_tag --timeout $remaining
      } catch {
        null
      })

    if ($candidate | is-empty) {
      break
    }

    if (($candidate.source? | default "") == "nu_git") and (($candidate.path? | default "") == $cwd) and (($candidate.job_id? | default null) == $job_id) {
      $messages = ($messages | append $candidate)
      break
    }
  }

  if ($messages | is-empty) {
    null
  } else {
    $messages.0
  }
}

export def --env status [] {
  if (which git | is-empty) {
    return []
  }

  let cwd = $env.PWD
  mut state = (kv get $git_state_key | default {
    path: "",
    job_id: null,
    stale: false,
    info: [],
  })

  if not ("stale" in $state) {
    $state = ($state | insert stale false)
  }

  if not ("info" in $state) {
    $state = ($state | insert info [])
  }

  if not ("job_id" in $state) {
    $state = ($state | insert job_id null)
  }

  if $state.path != $cwd {
    $state = {
      path: $cwd,
      job_id: null,
      stale: false,
      info: [],
    }
  }

  let job_id = if ($state.job_id | is-empty) {
    let new_job_id = (spawn-status-job $cwd)
    $state.job_id = $new_job_id
    $new_job_id
  } else {
    $state.job_id
  }

  # Each prompt gets one fresh-status wait; an active job is reused.
  let message = (wait-status-message $cwd $job_id $git_prompt_timeout)
  if ($message | is-empty) {
    $state.stale = not ($state.info | is-empty)
  } else {
    $state = (apply-status-message $state $message $cwd)
  }

  kv set $git_state_key $state | ignore
  if ($state.info | is-empty) {
    []
  } else {
    $state.info | upsert stale $state.stale
  }
}
