export def hostname [] {
  (sys).host.hostname
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
