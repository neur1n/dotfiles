export def ip [] {
  if (is-windows) {
    let addr = (ipconfig | find "IPv4 Address")
    if ($addr | is-empty) {
      "127.0.0.1"
    } else {
      $addr.0 | str replace -am '.*\b((\d{1,3}\.){3}\d{1,3})\b' '$1'
    }
  } else {
    (hostname -I | awk "{print $1}")
  }
}

export def is-apple [] {
  (sys).host.name == "Apple"
}

export def is-linux [] {
  (sys).host.long_os_version =~ ".*Linux.*"
}

export def is-windows [] {
  (sys).host.name == "Windows"
}

export def os-logo [] {
  if (is-apple) {
    "\u{f179}"
  } else if (is-windows) {
    "\u{f17a}"
  } else {
    "\u{f17c}"
  }
}
