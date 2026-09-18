export def ip [] {
  if ($nu.os-info.name == "linux") {
    let result = (
      ^ip -4 route get 1.1.1.1
      | ^awk '{for (i=1; i<=NF; i++) if ($i == "src") {print $(i+1); exit}}'
      | complete
    )

    let address = ($result.stdout | str trim)

    if ($result.exit_code == 0 and ($address | is-not-empty)) {
      $address
    } else {
      "127.0.0.1"
    }
  } else if ($nu.os-info.name == "macos") {
    let active = (
      ^scutil --nwi
      | lines
      | where {|line| ($line | str contains ": flags") and ($line | str contains "IPv4")}
    )

    let interface = if ($active | is-empty) {
      ""
    } else {
      $active.0
      | str trim
      | split row " "
      | where {|part| $part | is-not-empty}
      | first
    }

    if ($interface | is-empty) {
      "127.0.0.1"
    } else {
      let result = (^ipconfig getifaddr $interface | complete)
      let address = ($result.stdout | str trim)
      if ($result.exit_code == 0 and ($address | is-not-empty)) {
        $address
      } else {
        "127.0.0.1"
      }
    }
  } else if ($nu.os-info.name == "windows") {
    let result = (
      ^powershell -NoProfile -NonInteractive -Command '$routes = Get-NetRoute -AddressFamily IPv4 -DestinationPrefix "0.0.0.0/0"; $best = $routes | ForEach-Object { $interface = Get-NetIPInterface -AddressFamily IPv4 -InterfaceIndex $_.InterfaceIndex; [PSCustomObject]@{ InterfaceIndex = $_.InterfaceIndex; Metric = $_.RouteMetric + $interface.InterfaceMetric } } | Sort-Object Metric, InterfaceIndex | Select-Object -First 1; if ($null -ne $best) { Get-NetIPAddress -AddressFamily IPv4 -InterfaceIndex $best.InterfaceIndex | Where-Object { $_.AddressState -eq "Preferred" -and $_.IPAddress -notlike "127.*" -and $_.IPAddress -notlike "169.254.*" } | Select-Object -First 1 -ExpandProperty IPAddress }'
      | complete
    )

    let address = ($result.stdout | str trim)

    if ($result.exit_code == 0 and ($address | is-not-empty)) {
      $address
    } else {
      "127.0.0.1"
    }
  } else {
    "127.0.0.1"
  }
}

export def os-logo [] {
  if ($nu.os-info.name == "linux") {
    "\u{f17c}"
  } else if ($nu.os-info.name == "macos") {
    "\u{f179}"
  } else if ($nu.os-info.name == "windows") {
    "\u{f17a}"
  } else {
    "\u{f29c}"
  }
}
