export def ip [] {
  if ($nu.os-info.name == "windows") {
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

export def os-logo [] {
  if ($nu.os-info.name == "macos") {
    "\u{f179}"
  } else if ($nu.os-info.name == "windows") {
    "\u{f17a}"
  } else {
    "\u{f17c}"
  }
}
