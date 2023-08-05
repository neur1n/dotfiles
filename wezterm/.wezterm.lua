local Wezterm = require("wezterm")

local Colorscheme = require("colorscheme")
local Font = require("font")
local Launcher= require("launcher")
local Keymap= require("keymap")

Wezterm.on("update-right-status", function(window, pane)
  local date = Wezterm.strftime("%a %Y-%m-%d %H:%M ")
  window:set_right_status(date)
end)

local font = Font.get()

return {
  colors = Colorscheme.get(),
  default_cwd = ".",
  default_prog = {"nu"},
  enable_scroll_bar = true,
  font = Wezterm.font(font["name"]),
  font_size = font["size"],
  harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
  initial_cols = 120,
  initial_rows = 30,
  keys = Keymap.get(),
  launch_menu = Launcher.get(),
  line_height = 1.0,
  tab_bar_at_bottom = true,
  window_close_confirmation = "AlwaysPrompt",
  window_padding = {
    top = 0,
    bottom = 0,
    left = 0,
    right = 0,
  },
}
