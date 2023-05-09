local Colorschemes = require("colorschemes")
local Wezterm = require("wezterm")

Wezterm.on("update-right-status", function(window, pane)
  local date = Wezterm.strftime("%a %Y-%m-%d %H:%M:%S ")
  window:set_right_status(date)
end)

local fonts = {
  {["name"] = "3270 Nerd Font Mono"           , ["size"] = 12},
  {["name"] = "Agave Nerd Font Mono"          , ["size"] = 13},
  {["name"] = "CaskaydiaCove NFM"             , ["size"] = 12},
  {["name"] = "ComicShannsMono Nerd Font Mono", ["size"] = 12},
  {["name"] = "FantasqueSansM Nerd Font Mono" , ["size"] = 13},
  {["name"] = "FiraCode Nerd Font Mono Ret"   , ["size"] = 11},
  {["name"] = "GohuFont uni-11 Nerd Font Mono", ["size"] = 12},
  {["name"] = "GohuFont uni-14 Nerd Font Mono", ["size"] = 12},
  {["name"] = "Hurmit Nerd Font Mono"         , ["size"] = 11},
  {["name"] = "Input Nerd Font Mono"          , ["size"] = 12},
  {["name"] = "JetBrainsMono NFM"             , ["size"] = 11},
  {["name"] = "Maple Mono NF"                 , ["size"] = 11},
  {["name"] = "Monocraft Nerd Font"           , ["size"] = 10},
  {["name"] = "Monofur Nerd Font Mono"        , ["size"] = 13},
  {["name"] = "OpenDyslexicM Nerd Font Mono"  , ["size"] =  9},
  {["name"] = "ProFontWindows Nerd Font Mono" , ["size"] = 13},
  {["name"] = "ProggyCleanSZ Nerd Font Mono"  , ["size"] = 16},
  {["name"] = "SpaceMono Nerd Font Mono"      , ["size"] = 11},
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
      label = "Nushell",
      args = {"nu"}
    },
    {
      label = "WSL",
      args = {"wsl"}
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
