local M = {}

local palettes = {
  clack = {
    "#4e4e4e",
    "#dd6151",
    "#93c247",
    "#f2c700",
    "#5991ae",
    "#d37ba2",
    "#69d0a5",
    "#fafafa"
  },
  github = {
    "#666666",
    "#ea4a5a",
    "#34d058",
    "#ffea7f",
    "#2188ff",
    "#b392f0",
    "#39c5cf",
    "#e1e4e8",
  },
  iceberg = {
    "#444b71",
    "#e27878",
    "#b4bf82",
    "#e2a478",
    "#84a0c6",
    "#a093c8",
    "#89b8c2",
    "#d2d4de",
  },
  neovim = {
    "#75787e",
    "#ffc0b9",
    "#b3f6c0",
    "#fce094",
    "#a6dbff",
    "#ffcaff",
    "#8cf8f7",
    "#e0e2ea",
  },
  nightfox = {
    "#4e4e4e",
    "#c94f6d",
    "#81b29a",
    "#dbc074",
    "#719cd6",
    "#9d79d6",
    "#63cdcf",
    "#cdcecf",
  },
  synthwave = {
    "#4e4e4e",
    "#fe4450",
    "#72f1b8",
    "#ffe347",
    "#2ee2fa",
    "#af125a",
    "#3bf4fb",
    "#a2c7e5",
  },
}

local schemes = {
  -- clack
  {
    foreground    = "#fafafa",
    background    = "#1f1f2a",
    cursor_fg     = "#fafafa",
    cursor_bg     = "#e7feff",
    cursor_border = "#fafafa",
    selection_fg  = "#1f1f2a",
    selection_bg  = "#e2be7d",
    ansi = palettes["clack"],
    brights = palettes["clack"],
    tab_bar = {
      active_tab = {
        bg_color = palettes["clack"][math.random(2, 7)],
        fg_color = "#1f1f2a",
      },
    },
  },
  -- github
  {
    foreground    = "#e1e4e8",
    background    = "#24292e",
    cursor_fg     = "#e1e4e8",
    cursor_bg     = "#e7feff",
    cursor_border = "#e1e4e8",
    selection_fg  = "#24292e",
    selection_bg  = "#e2be7d",
    ansi = palettes["github"],
    brights = palettes["github"],
    tab_bar = {
      active_tab = {
        bg_color = palettes["github"][math.random(2, 7)],
        fg_color = "#24292e",
      },
    },
  },
  -- iceberg
  {
    foreground    = "#d2d4de",
    background    = "#161822",
    cursor_fg     = "#d2d4de",
    cursor_bg     = "#e7feff",
    cursor_border = "#d2d4de",
    selection_fg  = "#161822",
    selection_bg  = "#e2be7d",
    ansi = palettes["iceberg"],
    brights = palettes["iceberg"],
    tab_bar = {
      active_tab = {
        bg_color = palettes["iceberg"][math.random(2, 7)],
        fg_color = "#161822",
      },
    },
  },
  -- neovim
  {
    foreground    = "#d7dae1",
    background    = "#1c1d23",
    cursor_fg     = "#d7dae1",
    cursor_bg     = "#e7feff",
    cursor_border = "#d7dae1",
    selection_fg  = "#1c1d23",
    selection_bg  = "#e2be7d",
    ansi = palettes["neovim"],
    brights = palettes["neovim"],
    tab_bar = {
      active_tab = {
        bg_color = palettes["neovim"][math.random(2, 7)],
        fg_color = "#1c1d23",
      },
    },
  },
  -- nightfox
  {
    foreground    = "#cdcecf",
    background    = "#192330",
    cursor_fg     = "#cdcecf",
    cursor_bg     = "#e7feff",
    cursor_border = "#cdcecf",
    selection_fg  = "#192330",
    selection_bg  = "#e2be7d",
    ansi = palettes["nightfox"],
    brights = palettes["nightfox"],
    tab_bar = {
      active_tab = {
        bg_color = palettes["nightfox"][math.random(2, 7)],
        fg_color = "#192330",
      },
    },
  },
  -- synthwave
  {
    foreground    = "#a2c7e5",
    background    = "#262335",
    cursor_fg     = "#a2c7e5",
    cursor_bg     = "#e7feff",
    cursor_border = "#a2c7e5",
    selection_fg  = "#2e2a4f",
    selection_bg  = "#e2be7d",
    ansi = palettes["synthwave"],
    brights = palettes["synthwave"],
    tab_bar = {
      active_tab = {
        bg_color = palettes["synthwave"][math.random(2, 7)],
        fg_color = "#2e2a4f",
      },
    },
  },
}

function M.get()
  return schemes[math.random(#schemes)]
end

return M
