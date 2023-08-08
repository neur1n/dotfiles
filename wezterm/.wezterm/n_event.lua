local Wezterm = require("wezterm")

local IO = require("n_io")
local Pane = require("n_pane")
local Prompt = require("n_prompt")

local M = {}

local function ssh(window, _, event, split)
  local path = string.format("%s/.wezterm/%s.event", Wezterm.config_dir, event)
  local cmd = IO.get_line(path)

  if cmd ~= nil then
    local _, pane, _ = window:mux_window():spawn_tab{}
    local panes = Pane.split(pane, split)

    for _, p in pairs(panes) do
      p:send_text(cmd)
      p:send_text("nu\r")
    end
  end
end

local function invoke(window, pane, event)
  local patterns = {
    "(ssh%d+)%s*(%d*)",
  }

  for _, p in pairs(patterns) do
    local name, split = string.match(event, p)

    if name then
      ssh(window, pane, name, split)
    end
  end
end

function M.select()
  return Prompt.set("Select an event", invoke)
end

return M
