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

# Each fragment resets ANSI attributes, so apply bold to every fragment.
def render-fragment [obj: record] {
  nu_highlight render ($obj | update bol true)
}

def show-session [] {
  let lsep = (nu_highlight create "" $scheme.sess)

  let logo = (nu_system os-logo)
  let user = (
      if ($nu.os-info.name == "windows") {
        $env.USERNAME
      } else {
        (whoami)
      })
  let addr = (nu_system ip)

  let sess = (nu_highlight create $"($user)($logo)($addr)" $palette.bgh $scheme.sess)
  let rsep = (nu_highlight create "" $scheme.sess)

  $"(render-fragment $lsep)(render-fragment $sess)(render-fragment $rsep)"
}

def show-path [] {
  let path = (nu_highlight create $env.PWD $scheme.path)

  render-fragment $path
}

def show-git [git_status] {
  if ($git_status | is-empty) {
    ""
  } else if ($git_status.timeout? | default false) {
    let name = (nu_highlight create "()" $palette.fgh)

    render-fragment $name
  } else {
    let status = $git_status

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

    let name = (nu_highlight create ("(" + $b) $palette.fgh)
    let revc = (nu_highlight create $r $palette.fgh)
    let staged = (nu_highlight create $s $palette.green)
    let unstaged = (nu_highlight create $u $palette.red)
    let rsep = (nu_highlight create ")" $palette.fgh)

    $"(render-fragment $name)(render-fragment $revc)(render-fragment $staged)(render-fragment $unstaged)(render-fragment $rsep)"
  }
}

def show-timestamp [] {
  let lsep = (nu_highlight create "\n" $scheme.time)
  let ts = (nu_highlight create (date now | format date "%H:%M:%S") $palette.bgh $scheme.time)

  $"(render-fragment $lsep)(render-fragment $ts)"
}

def show-mode [mode: string] {
  let lsep = (nu_highlight create "" $scheme.venv $scheme.time)
  let emoji = (nu_highlight create $"(nu_emoji fetch)" $palette.bgh $scheme.venv)
  let rsep = (nu_highlight create (if ($mode == "i") {" "} else {" "}) $scheme.venv)

  $"(render-fragment $lsep)(render-fragment $emoji)(render-fragment $rsep)"
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

  $"(render-fragment $lsep)(render-fragment $venv)(render-fragment $rsep)"
}

def render-indicator [mode: string git_status] {
  let git = (show-git $git_status)
  let git = (if ($git | is-empty) {""} else {$" ($git)"})

  $"($git)(show-timestamp)(show-mode $mode)(show-venv)"
}

def update-git-indicators [git_status] {
  let insert = (render-indicator "i" $git_status)
  let normal = (render-indicator "n" $git_status)

  # Background Git updates must not replace the synchronous session/PWD prompt.
  commandline set-prompt --vi-insert $insert --vi-normal $normal
}

def left-prompt [] {
  let update = {|git_status| update-git-indicators $git_status}
  nu_git prepare $update | ignore
  $"(show-session)(show-path)"
}

def right-prompt [] {
  let timestamp = ([
      (date now | format date "%Y-%m-%d %H:%M:%S")
  ] | str join)

  let prompt = $"($timestamp)"

  $prompt
}

def indicator [mode: string] {
  render-indicator $mode (nu_git current)
}

$env.PROMPT_COMMAND = {|| left-prompt}
$env.PROMPT_COMMAND_RIGHT = {||}

$env.PROMPT_INDICATOR = {|| ""}
$env.PROMPT_INDICATOR_VI_INSERT = {|| indicator "i"}
$env.PROMPT_INDICATOR_VI_NORMAL = {|| indicator "n"}
$env.PROMPT_MULTILINE_INDICATOR = {|| render-fragment (nu_highlight create " \n::: ")}
