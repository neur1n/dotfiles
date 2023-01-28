local Colorschemes = require("colorschemes")
local Wezterm = require("wezterm")

Wezterm.on("update-right-status", function(window, pane)
  local date = Wezterm.strftime("%a %Y-%m-%d %H:%M:%S ")
  window:set_right_status(date)
end)

local fonts = {
  {["name"] = "3270SemiCondensed NFM"   , ["size"] = 14},
  {["name"] = "agave NFM"               , ["size"] = 13},
  {["name"] = "BigBlue_TerminalPlus NFM", ["size"] = 10},
  {["name"] = "CaskaydiaCove NFM"       , ["size"] = 12},
  {["name"] = "DaddyTimeMono NFM"       , ["size"] = 12},
  {["name"] = "FantasqueSansMono NFM"   , ["size"] = 13},
  {["name"] = "FiraCode NFM"            , ["size"] = 11},
  {["name"] = "GohuFont NFM"            , ["size"] = 12},
  {["name"] = "Hurmit NFM"              , ["size"] = 11},
  {["name"] = "Input NFM"               , ["size"] = 12},
  {["name"] = "JetBrainsMono NFM"       , ["size"] = 11},
  {["name"] = "Monofur NFM"             , ["size"] = 13},
  {["name"] = "OpenDyslexicMono NFM"    , ["size"] =  9},
  {["name"] = "ProFontWindows NFM"      , ["size"] = 13},
  {["name"] = "ProggyCleanTTSZ NFM"     , ["size"] = 16},
  {["name"] = "SpaceMono NFM"           , ["size"] = 11},
}
local font = fonts[math.random(#fonts)]

return {
  colors = Colorschemes.get(),
  default_cwd = ".",
  default_prog = {"nu"},
  enable_scroll_bar = true,
  font = Wezterm.font(font["name"]),
  font_size = font["size"],
  harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
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
  line_height = 1.0,
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
