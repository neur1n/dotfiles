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
  if is-apple {
    "\uf179"
  } else if is-linux {
    "\uf17c"
  } else if is-windows {
    "\uf17a"
  }
}
