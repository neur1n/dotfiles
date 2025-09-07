use std-rfc/kv *

use n_emoji.nu
use n_git.nu
use n_highlight.nu
use n_palette.nu
use n_system.nu


let palette = (n_palette fetch)
let rainbow = (n_palette rainbow $palette)

let maxidx = ($rainbow | length) - 1
let scheme = {
  sess: ($rainbow | get (random int 0..$maxidx)),
  path: ($rainbow | get (random int 0..$maxidx)),
  time: ($rainbow | get (random int 0..$maxidx)),
  venv: ($rainbow | get (random int 0..$maxidx)),
  indi: ($rainbow | get (random int 0..$maxidx))
}

def show-session [] {
  let sep = (n_highlight create "" $scheme.sess)

  let logo = (n_system os-logo)
  let user = (
      if ($nu.os-info.name == "windows") {
        $env.USERNAME
      } else {
        (whoami)
      })
  let addr = (n_system ip)

  let sess = (n_highlight create $"($user)($logo)($addr)" $palette.bgh $scheme.sess)

  $"(n_highlight render $sep)(n_highlight render $sess)"
}

def show-path [] {
  let lsep = (n_highlight create "" $scheme.path $scheme.sess)
  let path = (n_highlight create $env.PWD $palette.bgh $scheme.path)
  let rsep = (
      if (n_git in-repo) {
        (n_highlight create "" $scheme.path $palette.graym)
      } else {
        (n_highlight create "" $scheme.path)
      })

  $"(n_highlight render $lsep)(n_highlight render $path)(n_highlight render $rsep)"
}

def show-git [] {
  if not (n_git in-repo) {
    ""
  } else {
    let status = (n_git status)

    let r = ""  # rev count

    let acnt = $status.ahead
    let r = (if ($acnt > 0) {$"($r) ($acnt)"} else {$r})


    let bcnt = $status.behind
    let r = (if ($bcnt > 0) {$"($r) ($bcnt)"} else {$r})

    let has_upstream = ($status.upstream | is-not-empty)
    let b = (if not ($status.branch | str contains "(detached)") {$status.branch} else {$status.hash})
    let b = (if ($has_upstream and ($acnt == 0) and ($bcnt == 0)) {$"($b)"} else {$b})

    let s = ""  # staged

    let s = (
        if ($status.staged_added > 0) {
          $"($s) ($status.staged_added)"
        } else {
          $s
        })

    let s = (
        if ($status.staged_deleted > 0) {
          $"($s) ($status.staged_deleted)"
        } else {
          $s
        })

    let s = (
        if ($status.staged_modified > 0) {
          $"($s) ($status.staged_modified)"
        } else {
          $s
        })

    let u = ""  # unstaged

    let u = (
        if ($status.unstaged_deleted > 0) {
          $"($u) ($status.unstaged_deleted)"
        } else {
          $u
        })

    let u = (
        if ($status.unstaged_modified > 0) {
          $"($u) ($status.unstaged_modified)"
        } else {
          $u
        })

    let u = (
        if ($status.untracked > 0) {
          $"($u) ($status.untracked)"
        } else {
          $u
        })

    let u = (
        if ($status.conflict > 0) {
          $"($u) ($status.conflict)"
        } else {
          $u
        })

    let name = (n_highlight create $b $palette.bgh $palette.graym)
    let revc = (n_highlight create $r $palette.bgh $palette.graym)
    let staged = (n_highlight create $s $palette.green $palette.graym)
    let unstaged = (n_highlight create $u $palette.red $palette.graym)
    let rsep = (n_highlight create "" $palette.graym)

    $"(n_highlight render $name)(n_highlight render $revc)(n_highlight render $staged)(n_highlight render $unstaged)(n_highlight render $rsep)"
  }
}

def show-timestamp [] {
  let lsep = (n_highlight create "\n" $scheme.time)
  let ts = (n_highlight create (date now | format date "%H:%M:%S") $palette.bgh $scheme.time)

  $"(n_highlight render $lsep)(n_highlight render $ts)"
}

def show-mode [mode: string] {
  let lsep = (n_highlight create "" $scheme.venv $scheme.time)
  let emoji = (n_highlight create $"(n_emoji fetch)" $palette.bgh $scheme.venv)
  let rsep = (n_highlight create (if ($mode == "i") {" "} else {" "}) $scheme.venv)

  $"(n_highlight render $lsep)(n_highlight render $emoji)(n_highlight render $rsep)"
}

def show-venv [] {
  let envs = []

  let envs = (if ($env.MSVS_ACTIVATED? | default false) {
    $envs | append "󰘐"
  } else {
    $envs
  })

  let envs = (if not ($env.CONDA_CURR? | is-empty) {
    $envs | append $"󰌠($env.CONDA_CURR)"
  } else {
    $envs
  })

  let name = ($envs | str join "·")

  let lsep = (n_highlight create (if ($name | is-empty) {""} else {"["}) $scheme.venv)
  let venv = (n_highlight create $name $scheme.venv)
  let rsep = (n_highlight create (if ($name | is-empty) {""} else {"] "}) $scheme.venv)

  $"(n_highlight render $lsep)(n_highlight render $venv)(n_highlight render $rsep)"
}

def left-prompt [] {
  $"(show-session)(show-path)(show-git)"
}

def right-prompt [] {
  let timestamp = ([
      (date now | format date "%Y-%m-%d %H:%M:%S")
  ] | str join)

  let prompt = $"($timestamp)"

  $prompt
}

def indicator [mode: string] {
  $"(show-timestamp)(show-mode $mode)(show-venv)"
}

$env.PROMPT_COMMAND = {|| left-prompt}
$env.PROMPT_COMMAND_RIGHT = {||}

$env.PROMPT_INDICATOR = {|| ""}
$env.PROMPT_INDICATOR_VI_INSERT = {|| indicator "i"}
$env.PROMPT_INDICATOR_VI_NORMAL = {|| indicator "n"}
$env.PROMPT_MULTILINE_INDICATOR = {|| " \n::: "}
