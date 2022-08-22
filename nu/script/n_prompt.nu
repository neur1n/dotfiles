use n_os.nu
use n_hl.nu
use n_util.nu
source panache-git.nu
source n_colorscheme.nu

#==================================================================== colors{{{
let _c_1 = [$n_r , $n_o , $n_y , $n_g , $n_b , $n_c , $n_p]
let _c_2 = [$n_rr, $n_or, $n_yr, $n_gr, $n_br, $n_cr, $n_pr]
# colors}}}

#==================================================================== emojis{{{
let _emoji = [
  '😀', '😃', '😄', '😁', '😆', '😅', '🤣', '😂', '🙂', '🙃', '😉', '😊', '😇',
  '🥰', '😍', '🤩', '😘', '😗', '😚', '😙', '😋', '😛', '😜', '🤪', '😝', '🤑',
  '🤗', '🤭', '🤫', '🤔', '🤐', '🤨', '😐', '😑', '😶', '😶', '😶', '😏', '😒',
  '🙄', '😬', '😮', '🤥', '😌', '😔', '😪', '🤤', '😴', '😷', '🤒', '🤕', '🤢',
  '🤮', '🤧', '🥵', '🥶', '🥴', '😵', '😵', '🤯', '🤠', '🥳', '😎', '🤓', '🧐',
  '😕', '😟', '🙁', '😮', '😯', '😲', '😳', '🥺', '😦', '😧', '😨', '😰', '😥',
  '😢', '😭', '😱', '😖', '😣', '😞', '😓', '😩', '😫', '🥱', '😤', '😡', '😠',
  '🤬', '😈', '👿', '💀', '💩', '🤡', '👹', '👺', '👻', '👽', '👾', '🤖', '😺',
  '😸', '😹', '😻', '😼', '😽', '🙀', '😿', '😾', '🙈', '🙉', '🙊'
]
# emojis}}}

#======================================================================= git{{{
use panache-plumbing *
# git}}}

def left-prompt [] {
  let i1 = (n_util random-index $_c_1)
  let i2 = (n_util random-index $_c_1)
  let c1 = ($_c_1 | get $i1)
  let c2 = ($_c_1 | get $i2)

  let c_sep1 = $c1
  let c_sep2 = (n_hl combine $c1 $c2)
  let c_sep3 = $c2
  let c_who = (n_hl combine $n_bgh $c1)
  let c_pwd = (n_hl combine $n_bgh $c2)

  let sep1 = $"(n_hl render $c_sep1)"
  let sep2 = $"(n_hl render $c_sep2)"
  let sep3 = $"(n_hl render $c_sep3)(n_hl clear)"
  let who = $"(n_hl render $c_who)(n_os os-logo) (n_os hostname)" 
  let pwd = $"(n_hl render $c_pwd)($env.PWD)(n_hl clear)" 

  let prompt = $"($sep1)($who)($sep2)($pwd)($sep3)(n_hl clear)"

  $prompt
}

def right-prompt [] {
  let git = (panache-git styled)

  # let timestamp = ([
  #     (date now | date format "%Y-%m-%d %H:%M:%S")
  # ] | str collect)

  let prompt = $"($git)"

  $prompt
}

def vi-insert-indicator [] {
  let i = (n_util random-index $_c_1)
  let c_sep = ($_c_1 | get $i)
  let c_emo = (n_hl reverse $c_sep)

  let sep1 = $"(n_hl render $c_sep)"
  let emo = $"(n_hl render $c_emo)($_emoji | get (n_util random-index $_emoji))(n_hl clear)"
  let sep2 = $"(n_hl render $c_sep)(n_hl clear)"

  let indicator = $" (char newline)($sep1)($emo)($sep2) "

  $indicator
}

def vi-normal-indicator [] {
  let i = (n_util random-index $_c_1)
  let c_sep = ($_c_1 | get $i)
  let c_emo = (n_hl reverse $c_sep)

  let sep1 = $"(n_hl render $c_sep)"
  let emo = $"(n_hl render $c_emo)($_emoji | get (n_util random-index $_emoji))(n_hl clear)"
  let sep2 = $"(n_hl render $c_sep)(n_hl clear)"

  let indicator = $" (char newline)($sep1)($emo)($sep2) "

  $indicator
}

let-env PROMPT_COMMAND = {left-prompt}
let-env PROMPT_COMMAND_RIGHT = {right-prompt}

let-env PROMPT_INDICATOR = {""}
let-env PROMPT_INDICATOR_VI_INSERT = {vi-insert-indicator}
let-env PROMPT_INDICATOR_VI_NORMAL = {vi-normal-indicator}
let-env PROMPT_MULTILINE_INDICATOR = {" \n::: "}
