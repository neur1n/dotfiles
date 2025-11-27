use std-rfc/kv *

use nu_emoji.nu
use nu_git.nu
use nu_highlight.nu
use nu_palette.nu
use nu_system.nu


let palette = (nu_palette fetch)
let rainbow = (nu_palette rainbow $palette)

let maxidx = ($rainbow | length) - 1
let scheme = {
  sess: ($rainbow | get (random int 0..$maxidx)),
  path: ($rainbow | get (random int 0..$maxidx)),
  time: ($rainbow | get (random int 0..$maxidx)),
  venv: ($rainbow | get (random int 0..$maxidx)),
  indi: ($rainbow | get (random int 0..$maxidx))
}

def show-session [] {
  let sep = (nu_highlight create "" $scheme.sess)

  let logo = (nu_system os-logo)
  let user = (
      if ($nu.os-info.name == "windows") {
        $env.USERNAME
      } else {
        (whoami)
      })
  let addr = (nu_system ip)

  let sess = (nu_highlight create $"($user)($logo)($addr)" $palette.bgh $scheme.sess)

  $"(nu_highlight render $sep)(nu_highlight render $sess)"
}

def show-path [] {
  let lsep = (nu_highlight create "" $scheme.path $scheme.sess)
  let path = (nu_highlight create $env.PWD $palette.bgh $scheme.path)
  let rsep = (
      if (nu_git in-repo) {
        (nu_highlight create "" $scheme.path $palette.graym)
      } else {
        (nu_highlight create "" $scheme.path)
      })

  $"(nu_highlight render $lsep)(nu_highlight render $path)(nu_highlight render $rsep)"
}

def show-git [] {
  if not (nu_git in-repo) {
    ""
  } else {
    let status = (nu_git status)

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

    let name = (nu_highlight create $b $palette.bgh $palette.graym)
    let revc = (nu_highlight create $r $palette.bgh $palette.graym)
    let staged = (nu_highlight create $s $palette.green $palette.graym)
    let unstaged = (nu_highlight create $u $palette.red $palette.graym)
    let rsep = (nu_highlight create "" $palette.graym)

    $"(nu_highlight render $name)(nu_highlight render $revc)(nu_highlight render $staged)(nu_highlight render $unstaged)(nu_highlight render $rsep)"
  }
}

def show-timestamp [] {
  let lsep = (nu_highlight create "\n" $scheme.time)
  let ts = (nu_highlight create (date now | format date "%H:%M:%S") $palette.bgh $scheme.time)

  $"(nu_highlight render $lsep)(nu_highlight render $ts)"
}

def show-mode [mode: string] {
  let lsep = (nu_highlight create "" $scheme.venv $scheme.time)
  let emoji = (nu_highlight create $"(nu_emoji fetch)" $palette.bgh $scheme.venv)
  let rsep = (nu_highlight create (if ($mode == "i") {" "} else {" "}) $scheme.venv)

  $"(nu_highlight render $lsep)(nu_highlight render $emoji)(nu_highlight render $rsep)"
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

  let lsep = (nu_highlight create (if ($name | is-empty) {""} else {"["}) $scheme.venv)
  let venv = (nu_highlight create $name $scheme.venv)
  let rsep = (nu_highlight create (if ($name | is-empty) {""} else {"] "}) $scheme.venv)

  $"(nu_highlight render $lsep)(nu_highlight render $venv)(nu_highlight render $rsep)"
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
