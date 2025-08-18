use n_utility.nu


export def fetch [name?: string] {
  let s = ((special) | get (n_utility random-index (special)))

  if ($name == null) or (palettes | transpose k | find $name | is-empty) {
    let tbl = (palettes | transpose k v)
    let idx = (n_utility random-index $tbl.k)
    (($tbl.v | get $idx) | update special $s)
  } else {
    ((palettes | get $name) | update special $s)
  }
}

export def rainbow [plt: record] {
  [
    $plt.red,
    $plt.orange,
    $plt.yellow,
    $plt.green,
    $plt.cyan,
    $plt.blue,
    $plt.purple
  ]
}

def clack [] {
  {
    bgh    : "#16161d",
    bgm    : "#1f1f2a",
    bgs    : "#292937",
    fgh    : "#faebd7",
    fgm    : "#fafafa",
    fgs    : "#fffff0",
    grayh  : "#464646",
    graym  : "#4e4e4e",
    grays  : "#5f5f5f",
    red    : "#dd6151",
    orange : "#ffac00",
    yellow : "#f2c700",
    green  : "#93c247",
    cyan   : "#69d0a5",
    blue   : "#5991ae",
    purple : "#d37ba2",
    special: "#4f86f7"
  }
}

def github [] {
  {
    bgh    : "#1f2428",
    bgm    : "#24292e",
    bgs    : "#2c313a",
    fgh    : "#d1d5da",
    fgm    : "#e1e4e8",
    fgs    : "#fafbfc",
    grayh  : "#586069",
    graym  : "#666666",
    grays  : "#6a737d",
    red    : "#ea4a5a",
    orange : "#d18616",
    yellow : "#ffea7f",
    green  : "#34d058",
    cyan   : "#39c5cf",
    blue   : "#2188ff",
    purple : "#b392f0",
    special: "#4f86f7"
  }
}

def iceberg [] {
  {
    bgh    : "#0f1117",
    bgm    : "#161822",
    bgs    : "#1e2132",
    fgh    : "#c7c9d1",
    fgm    : "#d2d4de",
    fgs    : "#e8e9ec",
    grayh  : "#3e445e",
    graym  : "#444b71",
    grays  : "#6b7089",
    red    : "#e27878",
    orange : "#e2a578",
    yellow : "#fabd2f",
    green  : "#b5bf82",
    cyan   : "#89b9c2",
    blue   : "#84a0c7",
    purple : "#a093c8",
    special: "#4f86f7"
  }
}

def neovim [] {
  {
    bgh    : "#07080d",
    bgm    : "#14161b",
    bgs    : "#2c2e33",
    fgh    : "#eef1f8",
    fgm    : "#e0e2ea",
    fgs    : "#c4c6cd",
    grayh  : "#4f5258",
    graym  : "#75787e",
    grays  : "#9b9ea4",
    red    : "#ffc0b9",
    orange : "#fed0a7",
    yellow : "#fce094",
    green  : "#b3f6c0",
    cyan   : "#8cf8f7",
    blue   : "#a6dbff",
    purple : "#ffcaff",
    special: "#4f86f7"
  }
}

def nightfox [] {
  {
    bgh    : "#131a24",
    bgm    : "#192330",
    bgs    : "#212e3f",
    fgh    : "#d6d6d7",
    fgm    : "#cdcecf",
    fgs    : "#aeafb0",
    grayh  : "#464646",
    graym  : "#4e4e4e",
    grays  : "#5f5f5f",
    red    : "#c94f6d",
    orange : "#f4a261",
    yellow : "#dbc074",
    green  : "#81b29a",
    cyan   : "#63cdcf",
    blue   : "#719cd6",
    purple : "#9d79d6",
    special: "#4f86f7"
  }
}

def synthwave [] {
  {
    bgh    : "#201d2c",
    bgm    : "#262335",
    bgs    : "#2e2a4f",
    fgh    : "#d7b49e",
    fgm    : "#a2c7e5",
    fgs    : "#fbf9ff",
    grayh  : "#464646",
    graym  : "#4e4e4e",
    grays  : "#5f5f5f",
    red    : "#fe4450",
    orange : "#f39237",
    yellow : "#ffe347",
    green  : "#72f1b8",
    cyan   : "#3bf4fb",
    blue   : "#2ee2fa",
    purple : "#af125a",
    special: "#ff7edb"
  }
}

def special [] {
  ["#4f86f7", "#e2be7d"]
}

def palettes [] {
  {
    clack  : (clack),
    github: (github),
    iceberg: (iceberg),
    neovim: (neovim),
    nightfox: (nightfox),
    synthwave: (synthwave),
  }
}
