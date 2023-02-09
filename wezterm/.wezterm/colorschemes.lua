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
  gruvbox = {
    "#928374",
    "#fb4934",
    "#b8bb26",
    "#fabd2f",
    "#83a598",
    "#d3869b",
    "#8ec07c",
    "#ebdbb2",
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
  onedark = {
    "#5c6370",
    "#ef596f",
    "#89ca78",
    "#e5c07b",
    "#61afef",
    "#d55fde",
    "#2bbac5",
    "#abb2bf",
  },
}

local schemes = {
  -- clack
  {
    foreground    = "#fafafa",
    background    = "#16161d",
    cursor_fg     = "#fafafa",
    cursor_bg     = "#4f86f7",
    cursor_border = "#fafafa",
    selection_fg  = "#16161d",
    selection_bg  = "#e2be7d",
    ansi = palettes["clack"],
    brights = palettes["clack"],
    tab_bar = {
      active_tab = {
        bg_color = palettes["clack"][math.random(2, #palettes["clack"]-1)],
        fg_color = "#16161d",
      },
    },
  },
  -- gruvbox
  {
    foreground    = "#ebdbb2",
    background    = "#282828",
    cursor_fg     = "#ebdbb2",
    cursor_bg     = "#4f86f7",
    cursor_border = "#ebdbb2",
    selection_fg  = "#282828",
    selection_bg  = "#e2be7d",
    ansi = palettes["gruvbox"],
    brights = palettes["gruvbox"],
    tab_bar = {
      active_tab = {
        bg_color = palettes["gruvbox"][math.random(2, #palettes["gruvbox"]-1)],
        fg_color = "#16161d",
      },
    },
  },
  -- iceberg
  {
    foreground    = "#d2d4de",
    background    = "#161822",
    cursor_fg     = "#d2d4de",
    cursor_bg     = "#4f86f7",
    cursor_border = "#d2d4de",
    selection_fg  = "#161822",
    selection_bg  = "#e2be7d",
    ansi = palettes["iceberg"],
    brights = palettes["iceberg"],
    tab_bar = {
      active_tab = {
        bg_color = palettes["iceberg"][math.random(2, #palettes["iceberg"]-1)],
        fg_color = "#16161d",
      },
    },
  },
  -- onedark
  {
    foreground    = "#abb2bf",
    background    = "#282c34",
    cursor_fg     = "#abb2bf",
    cursor_bg     = "#4f86f7",
    cursor_border = "#abb2bf",
    selection_fg  = "#282c34",
    selection_bg  = "#e2be7d",
    ansi = palettes["onedark"],
    brights = palettes["onedark"],
    tab_bar = {
      active_tab = {
        bg_color = palettes["onedark"][math.random(2, #palettes["onedark"]-1)],
        fg_color = "#16161d",
      },
    },
  },
}

function M.get()
  return schemes[math.random(#schemes)]
end

return M
