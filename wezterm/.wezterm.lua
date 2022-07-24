local wezterm = require "wezterm"

local fonts = {
{["name"] = "Anonymice NF"        , ["size"] = 13},
{["name"] = "CaskaydiaCove NF"    , ["size"] = 12},
{["name"] = "DaddyTimeMono NF"    , ["size"] = 12},
{["name"] = "FantasqueSansMono NF", ["size"] = 13},
{["name"] = "FiraCode NF"         , ["size"] = 11},
{["name"] = "GohuFont NF"         , ["size"] = 12},
{["name"] = "Input NF"            , ["size"] = 12},
{["name"] = "ProggyCleanTT NF"    , ["size"] = 16},
{["name"] = "SpaceMono NF"        , ["size"] = 11},
{["name"] = "VictorMono NF"       , ["size"] = 12},
}
local font = fonts[math.random(#fonts)]

return {
  default_cwd = ".",
  default_prog = {"nu", ""},
  enable_scroll_bar = true,
  font = wezterm.font(font["name"]),
  font_size = font["size"],
  initial_cols = 120,
  initial_rows = 30,
  launch_menu = {
    {
      label = "Nu Shell",
      args = {"nu"}
    },
    {
      label = "Poweshell Core",
      args = {"pwsh"}
    },
  },
  tab_bar_at_bottom = true,
  window_close_confirmation = "NeverPrompt",
  keys = {
    {key = "l", mods = "CTRL|SHIFT", action = "ShowLauncher"},
  },
}
