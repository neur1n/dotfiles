export def clear [] {
  (ansi reset)
}

export def combine [fg: record, bg: record, attr = "n"] {
  {fg: $fg.fg, bg: $bg.fg, attr: $attr}
}

export def create [fg = "n", bg = "n", attr = "n"] {
  {fg: $fg, bg: $bg, attr: $attr}
}

export def render [color: record] {
  (ansi $color)
}

export def reverse [color: record] {
  {fg: $color.bg, bg: $color.fg, attr: $color.attr}
}
