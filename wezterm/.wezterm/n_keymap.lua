local Wezterm = require("wezterm")

local M = {}

local map = {
  {key = "UpArrow", mods = "ALT", action = Wezterm.action.ActivatePaneDirection("Up")},
  {key = "DownArrow", mods = "ALT", action = Wezterm.action.ActivatePaneDirection("Down")},
  {key = "LeftArrow", mods = "ALT", action = Wezterm.action.ActivatePaneDirection("Left")},
  {key = "RightArrow", mods = "ALT", action = Wezterm.action.ActivatePaneDirection("Right")},
  {key = "_", mods = "ALT|SHIFT", action = Wezterm.action.SplitPane{direction = "Down"}},
  {key = "+", mods = "ALT|SHIFT", action = Wezterm.action.SplitPane{direction = "Right"}},
  {key = "f", mods = "ALT|SHIFT", action = Wezterm.action.EmitEvent("select-font")},
  {key = "s", mods = "ALT|SHIFT", action = Wezterm.action.EmitEvent("select-snippet")},
}

function M.get()
  return map
end

return M
