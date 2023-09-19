local Wezterm = require("wezterm")

local Color = require("n_color")
local Font = require("n_font")
local Keymap= require("n_keymap")
local Launcher= require("n_launcher")

require("n_snippet")

Wezterm.on("gui-startup", function(_)
  local _, _, window = Wezterm.mux.spawn_window({})
  local dim = window:gui_window():get_dimensions()
  local scr = Wezterm.gui.screens()
  local x = (scr.active.width - dim.pixel_width) / 2
  local y = (scr.active.height - dim.pixel_height) / 2
  window:gui_window():set_position(x, y)
end)

Wezterm.on("update-right-status", function(window, pane)
  local date = Wezterm.strftime("%a %Y-%m-%d %H:%M ")
  window:set_right_status(date)
end)

local font = Font.get()

local config = {
  colors = Color.get(),
  default_cwd = ".",
  default_prog = {"nu"},
  enable_scroll_bar = true,
  font = Wezterm.font(font.name),
  font_size = font.size,
  harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
  initial_cols = 200,
  initial_rows = 50,
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

return config
