fn combine {|txt fgo bgo|
  put [
      &txt= $txt
      &fg=  $fgo[fg]
      &bg=  $bgo[bg]
      &bli= (or $fgo[bli] $bgo[bli])
      &bol= (or $fgo[bol] $bgo[bol])
      &dim= (or $fgo[dim] $bgo[dim])
      &inv= (or $fgo[inv] $bgo[inv])
      &ita= (or $fgo[ita] $bgo[ita])
      &und= (or $fgo[und] $bgo[und])
  ]
}

fn create {|txt
    &fg=default &bg=default &bli=$false &bol=$false
    &dim=$false &inv=$false &ita=$false &und=$false|
  put [
      &txt= $txt
      &fg=  $fg
      &bg=  $bg
      &bli= $bli
      &bol= $bol
      &dim= $dim
      &inv= $inv
      &ita= $ita
      &und= $und
  ]
}

fn render {|obj|
  var trans = (put "fg-"$obj[fg])

  set trans = (put $trans" bg-"$obj[bg])

  if $obj[bli] {
    set trans = (put $trans" blink")
  }

  if $obj[bol] {
    set trans = (put $trans" bold")
  }

  if $obj[dim] {
    set trans = (put $trans" dim")
  }

  if $obj[inv] {
    set trans = (put $trans" inverse")
  }

  if $obj[ita] {
    set trans = (put $trans" italic")
  }

  if $obj[und] {
    set trans = (put $trans" underlined")
  }

  styled $obj[txt] $trans
}

fn reverse {|obj|
  var r = (assoc $obj fg $obj.bg)
  set r = ((assoc $r bg $obj.fg))
  put $r

  # put [
  #     &txt= $obj[txt]
  #     &fg=  $obj[bg]
  #     &bg=  $obj[fg]
  #     &bli= $obj[bli]
  #     &bol= $obj[bol]
  #     &dim= $obj[dim]
  #     &inv= $obj[inv]
  #     &ita= $obj[ita]
  #     &und= $obj[und]
  # ]
}
