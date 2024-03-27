local M = {}

local clack = {
  name    = "clack",
  bgh     = {c = 234, g = "#16161d"},
  bgm     = {c = 235, g = "#1f1f2a"},
  bgs     = {c = 236, g = "#292937"},
  fgh     = {c = 230, g = "#faebd7"},
  fgm     = {c = 231, g = "#fafafa"},
  fgs     = {c = 231, g = "#fffff0"},
  grayh   = {c = 238, g = "#464646"},
  graym   = {c = 239, g = "#4e4e4e"},
  grays   = {c =  59, g = "#5f5f5f"},
  red     = {c = 167, g = "#dd6151"},
  orange  = {c = 214, g = "#ffac00"},
  yellow  = {c = 220, g = "#f2c700"},
  green   = {c = 107, g = "#93c247"},
  cyan    = {c =  79, g = "#69d0a5"},
  blue    = {c =  67, g = "#5991ae"},
  purple  = {c = 175, g = "#d37ba2"},
  special = {c = 180, g = "#e2be7d"}
}

local github = {
  name    = "github",
  bgh     = {c = 234, g = "#1f2428"},
  bgm     = {c = 235, g = "#24292e"},
  bgs     = {c = 236, g = "#2c313a"},
  fgh     = {c = 188, g = "#d1d5da"},
  fgm     = {c = 254, g = "#e1e4e8"},
  fgs     = {c = 231, g = "#fafbfc"},
  grayh   = {c = 241, g = "#586069"},
  graym   = {c = 242, g = "#666666"},
  grays   = {c = 243, g = "#6a737d"},
  red     = {c = 167, g = "#ea4a5a"},
  orange  = {c = 172, g = "#d18616"},
  yellow  = {c = 222, g = "#ffea7f"},
  green   = {c =  77, g = "#34d058"},
  cyan    = {c =  80, g = "#39c5cf"},
  blue    = {c =  33, g = "#2188ff"},
  purple  = {c = 141, g = "#b392f0"},
  special = {c = 180, g = "#e2be7d"}
}

local iceberg = {
  name    = "iceberg",
  bgh     = {c = 233, g = "#0f1117"},
  bgm     = {c = 234, g = "#161822"},
  bgs     = {c = 235, g = "#1e2132"},
  fgh     = {c = 252, g = "#c7c9d1"},
  fgm     = {c = 188, g = "#d2d4de"},
  fgs     = {c = 255, g = "#e8e9ec"},
  grayh   = {c = 239, g = "#3e445e"},
  graym   = {c = 240, g = "#444b71"},
  grays   = {c =  60, g = "#6b7089"},
  red     = {c = 174, g = "#e27878"},
  orange  = {c = 180, g = "#e2a478"},
  yellow  = {c = 180, g = "#e9b189"},
  green   = {c = 144, g = "#b4be82"},
  cyan    = {c = 109, g = "#89b8c2"},
  blue    = {c = 110, g = "#84a0c6"},
  purple  = {c = 140, g = "#a093c7"},
  special = {c = 180, g = "#e2be7d"}
}

local neovim = {
  name    = "neovim",
  bgh     = {c = 232, g = "#0a0b10"},
  bgm     = {c = 234, g = "#1c1d23"},
  bgs     = {c = 236, g = "#2c2e33"},
  fgh     = {c = 255, g = "#ebeef5"},
  fgm     = {c = 253, g = "#d7dae1"},
  fgs     = {c = 251, g = "#c4c6cd"},
  grayh   = {c = 240, g = "#4f5258"},
  graym   = {c = 243, g = "#75787e"},
  grays   = {c = 247, g = "#9b9ea4"},
  red     = {c = 225, g = "#ffc3fa"},
  orange  = {c = 217, g = "#ffbcb5"},
  yellow  = {c = 222, g = "#f4d88c"},
  green   = {c = 157, g = "#aaedb7"},
  cyan    = {c = 123, g = "#83efef"},
  blue    = {c = 153, g = "#9fd8ff"},
  purple  = {c = 189, g = "#cfcefd"},
  special = {c = 180, g = "#e2be7d"}
}

local nightfox = {
  name    = "nightfox",
  bgh     = {c = 234, g = "#131a24"},
  bgm     = {c = 235, g = "#192330"},
  bgs     = {c = 236, g = "#212e3f"},
  fgh     = {c = 188, g = "#d6d6d7"},
  fgm     = {c = 252, g = "#cdcecf"},
  fgs     = {c = 145, g = "#aeafb0"},
  grayh   = {c = 239, g = "#464646"},
  graym   = {c = 240, g = "#4e4e4e"},
  grays   = {c =  60, g = "#5f5f5f"},
  red     = {c = 167, g = "#c94f6d"},
  orange  = {c = 215, g = "#f4a261"},
  yellow  = {c = 180, g = "#dbc074"},
  green   = {c = 108, g = "#81b29a"},
  cyan    = {c =  80, g = "#63cdcf"},
  blue    = {c =  74, g = "#719cd6"},
  purple  = {c = 140, g = "#9d79d6"},
  special = {c = 180, g = "#e2be7d"}
}

local synthwave = {
  name    = "synthwave",
  bgh     = {c = 235, g = "#262335"},
  bgm     = {c = 237, g = "#2e2a4f"},
  bgs     = {c = 238, g = "#353163"},
  fgh     = {c = 181, g = "#d7b49e"},
  fgm     = {c = 152, g = "#a2c7e5"},
  fgs     = {c = 231, g = "#fbf9ff"},
  grayh   = {c = 238, g = "#464646"},
  graym   = {c = 239, g = "#4e4e4e"},
  grays   = {c =  59, g = "#5f5f5f"},
  red     = {c = 203, g = "#fe4450"},
  orange  = {c = 209, g = "#f39237"},
  yellow  = {c = 221, g = "#ffe347"},
  green   = {c =  85, g = "#72f1b8"},
  cyan    = {c =  87, g = "#3bf4fb"},
  blue    = {c =  45, g = "#2ee2fa"},
  purple  = {c = 125, g = "#af125a"},
  special = {c = 212, g = "#ff7edb"}
}

local palettes = {
  clack,
  github,
  iceberg,
  neovim,
  nightfox,
  synthwave,
}

local current = "unknown"

function M.current()
  return current
end

function M.get(name)
  if palettes[name] then
    current = name
    return palettes[name]
  else
    math.randomseed(os.time())
    local idx = math.random(#palettes)
    current = palettes[idx].name
    return palettes[idx]
  end
end

return M
