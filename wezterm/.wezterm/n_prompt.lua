local M = {}

local Wezterm = require("wezterm")

function M.set(text, callback)
  return Wezterm.action.PromptInputLine{
    description = Wezterm.format{
      {Attribute = {Intensity = "Bold"}},
      {Text = text},
    },
    action = Wezterm.action_callback(callback)
  }
end

return M
