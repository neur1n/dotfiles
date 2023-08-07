local M = {}

local Wezterm = require("wezterm")

local Prompt = require("n_prompt")

local map = {
  {key = "UpArrow", mods = "ALT", action = Wezterm.action.ActivatePaneDirection("Up")},
  {key = "DownArrow", mods = "ALT", action = Wezterm.action.ActivatePaneDirection("Down")},
  {key = "LeftArrow", mods = "ALT", action = Wezterm.action.ActivatePaneDirection("Left")},
  {key = "RightArrow", mods = "ALT", action = Wezterm.action.ActivatePaneDirection("Right")},
  {key = "l", mods = "CTRL|SHIFT", action = Wezterm.action.ShowLauncher},
  {key = "_", mods = "ALT|SHIFT", action = Wezterm.action.SplitPane {direction = "Down"}},
  {key = "+", mods = "ALT|SHIFT", action = Wezterm.action.SplitPane {direction = "Right"}},
}

function M.get()
  return map
end

return M
