local Wezterm = require("wezterm")

local M = {}

local map = {
  {key = "_", mods = "ALT|SHIFT", action = Wezterm.action.SplitPane{direction = "Down"}},
  {key = "+", mods = "ALT|SHIFT", action = Wezterm.action.SplitPane{direction = "Right"}},
  {key = "f", mods = "ALT|SHIFT", action = Wezterm.action.EmitEvent("select-font")},
  {key = "s", mods = "ALT|SHIFT", action = Wezterm.action.EmitEvent("select-snippet")},
  {key = "Enter", mods = "CTRL", action = Wezterm.action.SendString("\x1b[13;5u")},
}

function M.get()
  return map
end

return M
