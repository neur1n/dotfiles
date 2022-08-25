local Colorschemes = require("colorschemes")
local Wezterm = require("wezterm")

Wezterm.on("update-right-status", function(window, pane)
  local date = Wezterm.strftime("%a %Y-%m-%d %H:%M ")
  window:set_right_status(date)
end)

local fonts = {
{["name"] = "Anonymice NF"        , ["size"] = 13},
{["name"] = "CaskaydiaCove NF"    , ["size"] = 12},
{["name"] = "DaddyTimeMono NF"    , ["size"] = 12},
{["name"] = "FantasqueSansMono NF", ["size"] = 13},
{["name"] = "FiraCode NF"         , ["size"] = 11},
{["name"] = "GohuFont NF"         , ["size"] = 12},
{["name"] = "Input NF"            , ["size"] = 12},
{["name"] = "JetBrainsMono NF"    , ["size"] = 11},
{["name"] = "ProggyCleanTT NF"    , ["size"] = 16},
{["name"] = "SauceCodePro NF"     , ["size"] = 11},
{["name"] = "SpaceMono NF"        , ["size"] = 11},
{["name"] = "VictorMono NF"       , ["size"] = 12},
}
local font = fonts[math.random(#fonts)]

return {
  colors = Colorschemes.get(),
  default_cwd = ".",
  default_prog = {"nu", ""},
  enable_scroll_bar = true,
  font = Wezterm.font(font["name"]),
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
  window_padding = {
    top = 0,
    bottom = 0,
    left = 0,
    right = 0,
  },
  keys = {
    {key = "UpArrow", mods = "ALT", action = Wezterm.action.ActivatePaneDirection("Up")},
    {key = "DownArrow", mods = "ALT", action = Wezterm.action.ActivatePaneDirection("Down")},
    {key = "LeftArrow", mods = "ALT", action = Wezterm.action.ActivatePaneDirection("Left")},
    {key = "RightArrow", mods = "ALT", action = Wezterm.action.ActivatePaneDirection("Right")},
    {key = "l", mods = "CTRL|SHIFT", action = Wezterm.action.ShowLauncher},
    {key = "_", mods = "ALT|SHIFT", action = Wezterm.action.SplitPane {direction = "Down"}},
    {key = "+", mods = "ALT|SHIFT", action = Wezterm.action.SplitPane {direction = "Right"}},
  },
}
