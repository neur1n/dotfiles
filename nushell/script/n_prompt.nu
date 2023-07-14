use n_emo.nu
use n_sys.nu
use n_hl.nu
use n_plt.nu
use n_util.nu
use panache-git.nu


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
      if (n_sys is-windows) {
        $env.USERNAME
      } else {
        (whoami)
      })
  let addr = (n_sys ip)

  let sess = (n_hl create $"($logo) ($user)@($addr)" $palette.bgh $cs.sess)

  $"(n_hl render $sep)(n_hl render $sess)"
}

def show-path [] {
  let gstatus = (panache-git repo-structured)

  let lsep = (n_hl create "" $cs.path $cs.sess)
  let path = (n_hl create $env.PWD $palette.bgh $cs.path)
  let rsep = (
      if $gstatus.in_git_repo {
        (n_hl create "" $cs.path $palette.graym)
      } else {
        (n_hl create "" $cs.path)
      })

  $"(n_hl render $lsep)(n_hl render $path)(n_hl render $rsep)"
}

def show-git [] {
  let gstatus = (panache-git repo-structured)

  if (not $gstatus.in_git_repo) {
    ""
  } else {
    let r = ""  # rev count

    let acnt = $gstatus.commits_ahead
    let r = (if ($acnt > 0) {$"($r) ($acnt)"} else {$r})


    let bcnt = $gstatus.commits_behind
    let r = (if ($bcnt > 0) {$"($r) ($bcnt)"} else {$r})

    let has_remote = $gstatus.tracking_upstream_branch
    let b = (if $gstatus.on_named_branch {$"($gstatus.branch_name)"} else {$"($gstatus.commit_hash)"})
    let b = (if ($has_remote and ($acnt == 0) and ($bcnt == 0)) {$"($b)"} else {$b})

    let s = ""  # staged

    let s = (
        if ($gstatus.staging_added_count > 0) {
          $"($s) ($gstatus.staging_added_count)"
        } else {
          $s
        })

    let s = (
        if ($gstatus.staging_modified_count > 0) {
          $"($s) ($gstatus.staging_modified_count)"
        } else {
          $s
        })

    let s = (
        if ($gstatus.staging_deleted_count > 0) {
          $"($s) ($gstatus.staging_deleted_count)"
        } else {
          $s
        })

    let l = ""  # local

    let l = (
        if ($gstatus.untracked_count > 0) {
          $"($l) ($gstatus.untracked_count)"
        } else {
          $l
        })

    let l = (
        if ($gstatus.worktree_modified_count > 0) {
          $"($l) ($gstatus.worktree_modified_count)"
        } else {
          $l
        })

    let l = (
        if ($gstatus.worktree_deleted_count > 0) {
          $"($l) ($gstatus.worktree_deleted_count)"
        } else {
          $l
        })

    let name = (n_hl create $b $palette.bgh $palette.graym)
    let revc = (n_hl create $r $palette.bgh $palette.graym)
    let staged = (n_hl create $s $palette.green $palette.graym)
    let local = (n_hl create $l $palette.red $palette.graym)
    let rsep = (n_hl create "" $palette.graym)

    $"(n_hl render $name)(n_hl render $revc)(n_hl render $staged)(n_hl render $local)(n_hl render $rsep)"
  }
}

def show-timestamp [] {
  let lsep = (n_hl create "\n" $cs.time)
  let ts = (n_hl create (date now | date format "%H:%M:%S") $palette.bgh $cs.time)

  $"(n_hl render $lsep)(n_hl render $ts)"
}

def show-venv [mode: string] {
  let sym = (if ($mode == "i") {" "} else {" "})

  let name = (
    if (not "CONDA_CURR" in $env) or ($env.CONDA_CURR == null) {
      ""
    } else {
      $env.CONDA_CURR
    })

  let lsep = (n_hl create "" $cs.venv $cs.time)
  let venv = (n_hl create $"(n_emo get-emoji)($name)" $palette.bgh $cs.venv)
  let rsep = (n_hl create $sym $cs.venv)

  $"(n_hl render $lsep)(n_hl render $venv)(n_hl render $rsep)"
}

def left-prompt [] {
  $"(show-session)(show-path)(show-git)"
}

def right-prompt [] {
  let timestamp = ([
      (date now | date format "%Y-%m-%d %H:%M:%S")
  ] | str collect)

  let prompt = $"($timestamp)"

  $prompt
}

def indicator [mode: string] {
  $"(show-timestamp)(show-venv $mode)"
}

let-env PROMPT_COMMAND = {|| left-prompt}
let-env PROMPT_COMMAND_RIGHT = {|| ""}

let-env PROMPT_INDICATOR = {|| ""}
let-env PROMPT_INDICATOR_VI_INSERT = {|| indicator "i"}
let-env PROMPT_INDICATOR_VI_NORMAL = {|| indicator "n"}
let-env PROMPT_MULTILINE_INDICATOR = {|| " \n::: "}
