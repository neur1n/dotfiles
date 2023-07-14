export def ip [] {
  if (is-windows) {
    (ipconfig | find "IPv4 Address").0 | str replace ".*\\b((\\d{1,3}\\.){3}\\d{1,3})" "$1"
  } else {
    (hostname -I | awk "{print $1}")
  }
}

export def is-apple [] {
  (sys).host.name == "Apple"
}

export def is-linux [] {
  (sys).host.name == "Linux"
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
