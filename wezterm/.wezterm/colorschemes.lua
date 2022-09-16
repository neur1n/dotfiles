local M = {}

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
    ansi = {
      "#4e4e4e",
      "#dd6151",
      "#93c247",
      "#f2c700",
      "#5991ae",
      "#d37ba2",
      "#69d0a5",
      "#fafafa",
    },
    brights = {
      "#4e4e4e",
      "#dd6151",
      "#93c247",
      "#f2c700",
      "#5991ae",
      "#d37ba2",
      "#69d0a5",
      "#fafafa",
    }
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
    ansi = {
      "#928374",
      "#fb4934",
      "#b8bb26",
      "#fabd2f",
      "#83a598",
      "#d3869b",
      "#8ec07c",
      "#ebdbb2",
    },
    brights = {
      "#928374",
      "#fb4934",
      "#b8bb26",
      "#fabd2f",
      "#83a598",
      "#d3869b",
      "#8ec07c",
      "#ebdbb2",
    }
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
    ansi = {
      "#444b71",
      "#e27878",
      "#b4bf82",
      "#e2a478",
      "#84a0c6",
      "#a093c8",
      "#89b8c2",
      "#d2d4de",
    },
    brights = {
      "#444b71",
      "#e27878",
      "#b4bf82",
      "#e2a478",
      "#84a0c6",
      "#a093c8",
      "#89b8c2",
      "#d2d4de",
    }
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
    ansi = {
      "#5c6370",
      "#ef596f",
      "#89ca78",
      "#e5c07b",
      "#61afef",
      "#d55fde",
      "#2bbac5",
      "#abb2bf",
    },
    brights = {
      "#5c6370",
      "#ef596f",
      "#89ca78",
      "#e5c07b",
      "#61afef",
      "#d55fde",
      "#2bbac5",
      "#abb2bf",
    }
  },
}

function M.get()
  local i = math.random(#schemes)
  return schemes[i]
end

return M
