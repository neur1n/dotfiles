use n_emo.nu
use n_sys.nu
use n_git.nu
use n_hl.nu
use n_plt.nu
use n_util.nu


let palette = (n_plt get-palette)
let rainbow = (n_plt get-rainbow $palette)

let cs = {
  sess: ($rainbow | get (n_util random-index $rainbow)),
  path: ($rainbow | get (n_util random-index $rainbow)),
  time: ($rainbow | get (n_util random-index $rainbow)),
  venv: ($rainbow | get (n_util random-index $rainbow)),
  indi: ($rainbow | get (n_util random-index $rainbow))
}

def show-session [] {
  let sep = (n_hl create "" $cs.sess)

  let logo = (n_sys os-logo)
  let user = (
      if ($nu.os-info.name == "windows") {
        $env.USERNAME
      } else {
        (whoami)
      })
  let addr = (n_sys ip)

  let sess = (n_hl create $"($user)($logo)($addr)" $palette.bgh $cs.sess)

  $"(n_hl render $sep)(n_hl render $sess)"
}

def show-path [] {
  let lsep = (n_hl create "" $cs.path $cs.sess)
  let path = (n_hl create $env.PWD $palette.bgh $cs.path)
  let rsep = (
      if (n_git in-repo) {
        (n_hl create "" $cs.path $palette.graym)
      } else {
        (n_hl create "" $cs.path)
      })

  $"(n_hl render $lsep)(n_hl render $path)(n_hl render $rsep)"
}

def show-git [] {
  if not (n_git in-repo) {
    return ""
  }

  let status = (n_git status)

  if not (n_git in-repo) {
    ""
  } else {
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

    let name = (n_hl create $b $palette.bgh $palette.graym)
    let revc = (n_hl create $r $palette.bgh $palette.graym)
    let staged = (n_hl create $s $palette.green $palette.graym)
    let unstaged = (n_hl create $u $palette.red $palette.graym)
    let rsep = (n_hl create "" $palette.graym)

    $"(n_hl render $name)(n_hl render $revc)(n_hl render $staged)(n_hl render $unstaged)(n_hl render $rsep)"
  }
}

def show-timestamp [] {
  let lsep = (n_hl create "\n" $cs.time)
  let ts = (n_hl create (date now | format date "%H:%M:%S") $palette.bgh $cs.time)

  $"(n_hl render $lsep)(n_hl render $ts)"
}

def show-mode [mode: string] {
  let lsep = (n_hl create "" $cs.venv $cs.time)
  let emo = (n_hl create $"(n_emo get-emoji)" $palette.bgh $cs.venv)
  let rsep = (n_hl create (if ($mode == "i") {" "} else {" "}) $cs.venv)

  $"(n_hl render $lsep)(n_hl render $emo)(n_hl render $rsep)"
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

  let lsep = (n_hl create (if ($name | is-empty) {""} else {"["}) $cs.venv)
  let venv = (n_hl create $name $cs.venv)
  let rsep = (n_hl create (if ($name | is-empty) {""} else {"] "}) $cs.venv)

  $"(n_hl render $lsep)(n_hl render $venv)(n_hl render $rsep)"
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
$env.PROMPT_COMMAND_RIGHT = {|| ""}

$env.PROMPT_INDICATOR = {|| ""}
$env.PROMPT_INDICATOR_VI_INSERT = {|| indicator "i"}
$env.PROMPT_INDICATOR_VI_NORMAL = {|| indicator "n"}
$env.PROMPT_MULTILINE_INDICATOR = {|| " \n::: "}
