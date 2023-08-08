local Wezterm = require("wezterm")

local Pane = require("n_pane")
local Prompt = require("n_prompt")

local M = {}

local function load_event(path, limit)
  local f = io.open(path,"r")

  if f == nil then
    return {}
  end

  local event = {}
  local count = 0

  for line in f:lines() do
    if limit > 0 and count >= limit then
      break
    end
    count = count + 1

    local lhs, rhs = string.match(line, "^(.-)%s+(%d+)$")
    if lhs ~= nil then
      rhs = rhs ~= nil and rhs or 0
    end
    event[count] = {lhs, rhs}
  end

  return event
end

local function run(window, _, event, split)
  local path = string.format("%s/.wezterm/%s.event", Wezterm.config_dir, event)
  local event = load_event(path, -1)

  if #event ~= 0 then
    local _, pane, _ = window:mux_window():spawn_tab{}
    local panes = Pane.split(pane, split)

    for _, p in pairs(panes) do
      for _, c in pairs(event) do
        p:send_text(c[1] .. "\r")
        Wezterm.sleep_ms(c[2])
      end
    end
  end
end

local function invoke(window, pane, event)
  local patterns = {
    "([^%s]+)%s*(%d*)",
  }

  for _, p in pairs(patterns) do
    local name, split = string.match(event, p)

    if name then
      run(window, pane, name, split)
    end
  end
end

function M.select()
  return Prompt.set("Select an event", invoke)
end

return M
