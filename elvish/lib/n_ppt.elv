use git
use str
use n_emo
use n_hl
use n_os
use n_plt


var palette = ($n_plt:get-palette~)
var rainbow = ($n_plt:get-rainbow~ $palette)

var last = $palette[bgh]

fn show-logo {
  var i = (randint (count $rainbow))
  var c = $rainbow[$i]

  var sep = ($n_hl:create~ "" &fg=$c)
  var logo = ($n_hl:create~ ($n_os:logo~) &fg=$palette[bgh] &bg=$c)

  set last = $c
  
  $n_hl:render~ $sep
  $n_hl:render~ $logo
}

fn show-path {
  var i = (randint (count $rainbow))
  var c = $rainbow[$i]

  var lsep = ($n_hl:create~ "" &fg=$c &bg=$last)
  var path = ($n_hl:create~ (tilde-abbr $pwd) &fg=$palette[bgh] &bg=$c)
  var rsep = ({
      if ($git:status~)[is-git-repo] {
        put ($n_hl:create~ "" &fg=$c &bg=$palette[grays])
      } else {
        put ($n_hl:create~ "" &fg=$c)
      }
  })

  $n_hl:render~ $lsep
  $n_hl:render~ $path
  $n_hl:render~ $rsep
}

fn show-git {
  if (not ($git:status~)[is-git-repo]) {
    return
  }

  var r = ""  # rev count

  var acnt = (num ($git:status~)[rev-ahead])
  if (> $acnt 0) {
    set r = (put $r" "$acnt)
  }

  var bcnt = (num ($git:status~)[rev-behind])
  if (> $bcnt 0) {
    set r = (put $r" "$bcnt)
  }

  var b = (put ""($git:branch_name~))
  var has_remote = ({
      var cmd = { git --no-optional-locks status --porcelain=2 --branch }
      var found = $false
      $cmd | each {|x| if ($str:contains~ $x "branch.ab") { set found = (or $found $true) }}
      put $found
  })
  if (and $has_remote (== (num $acnt) 0) (== (num $bcnt) 0)) {
    set b = (put $b"")
  }

  var cnt = 0

  var s = ""  # staged

  set cnt = (count ($git:status~)[staged-added])
  if (> $cnt 0) {
    set s = (put $s" "$cnt)
  }

  set cnt = (count ($git:status~)[staged-modified])
  if (> $cnt 0) {
    set s = (put $s" "$cnt)
  }

  set cnt = (count ($git:status~)[staged-deleted])
  if (> $cnt 0) {
    set s = (put $s" "$cnt)
  }

  var l = ""  # local

  set cnt = (count ($git:status~)[untracked])
  if (> $cnt 0) {
    set l = (put $l" "$cnt)
  }

  set cnt = (count ($git:status~)[local-modified])
  if (> $cnt 0) {
    set l = (put $l" "$cnt)
  }

  set cnt = (count ($git:status~)[local-deleted])
  if (> $cnt 0) {
    set l = (put $l" "$cnt)
  }

  var name = ($n_hl:create~ $b &fg=$palette[bgh] &bg=$palette[grays])
  var revc = ($n_hl:create~ $r &fg=$palette[bgh] &bg=$palette[grays])
  var staged = ($n_hl:create~ $s &fg=$palette[green] &bg=$palette[grays])
  var local = ($n_hl:create~ $l &fg=$palette[red] &bg=$palette[grays])
  var rsep = ($n_hl:create~ "" &fg=$palette[grays])

  $n_hl:render~ $name
  $n_hl:render~ $revc
  $n_hl:render~ $staged
  $n_hl:render~ $local
  $n_hl:render~ $rsep
}

fn show-timestamp {
  if (not (has-external date)) {
    return
  }

  var i = (randint (count $rainbow))
  var c = $rainbow[$i]

  var lsep = ($n_hl:create~ "\n" &fg=$c)
  var ts = ($n_hl:create~ (date +"%H:%M:%S") &fg=$palette[bgh] &bg=$c)

  set last = $c

  $n_hl:render~ $lsep
  $n_hl:render~ $ts
}

fn show-indicator {
  var i = (randint (count $rainbow))
  var c = $rainbow[$i]

  var lsep = ($n_hl:create~ "" &fg=$c &bg=$last)
  var emo = ($n_hl:create~ ($n_emo:get~) &bg=$c)
  var rsep = ($n_hl:create~ " " &fg=$c)

  $n_hl:render~ $lsep
  $n_hl:render~ $emo
  $n_hl:render~ $rsep
}

set edit:prompt = {
  $show-logo~;
  $show-path~;
  $show-git~;

  $show-timestamp~;
  $show-indicator~;
}

set edit:rprompt = {
}
