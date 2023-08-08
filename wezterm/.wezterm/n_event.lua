local Wezterm = require("wezterm")

local IO = require("n_io")
local Pane = require("n_pane")
local Prompt = require("n_prompt")

local M = {}

local function ssh(window, _, event)
  local path = string.format("%s/.wezterm/%s.event", Wezterm.config_dir, event)
  local cmd = IO.get_line(path)

  if cmd ~= nil then
    local _, pane, _ = window:mux_window():spawn_tab{}
    local panes = Pane.split4(pane)

    for _, p in pairs(panes) do
      p:send_text(cmd)
      p:send_text("nu\r")
    end
  end
end

local function invoke(window, pane, event)
  if string.match(event, "ssh%d+") then
    ssh(window, pane, event)
  end
end

function M.select()
  return Prompt.set("Select an event", invoke)
end

return M
