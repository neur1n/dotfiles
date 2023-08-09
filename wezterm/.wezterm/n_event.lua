local Wezterm = require("wezterm")

local Pane = require("n_pane")
local Prompt = require("n_prompt")

local M = {}

local function load(path)
  local f = io.open(path,"r")

  if f == nil then
    return {}
  end

  local json = Wezterm.json_parse((f:read("a")))
  f:close()

  local event = {}

  for _, e in pairs(json.event) do
    local cmd, ms = next(e)
    table.insert(event, {[cmd] = ms})
  end

  return event
end

local function invoke(window, pane, name, new, split)
  local path = string.format("%s/.wezterm/%s.json", Wezterm.config_dir, name)
  local event = load(path)

  if #event ~= 0 then
    local panes = nil

    if new then
      local _, p, _ = window:mux_window():spawn_tab{}
      panes = Pane.split(p, split)
    else
      panes = Pane.split(pane, split)
    end

    local cmd = nil
    local ms = nil

    -- NOTE: Iterating 'event' in the outer loop requires shorter sleeps.
    for _, e in ipairs(event) do
      for _, p in pairs(panes) do
        cmd, ms = next(e)
        p:send_text(cmd .. "\r")
        Wezterm.sleep_ms(ms)
      end
    end
  end
end

local function parse(window, pane, line)
  local patterns = {
    "([^%s]+)%s+([ft])%s*(%d*)",
  }

  for _, p in pairs(patterns) do
    local name, new, split = string.match(line, p)

    if name ~=nil and new ~= nil then
      invoke(window, pane, name, (new == "t" or false), split)
    end
  end
end

function M.select()
  return Prompt.set("Select an event", parse)
end

return M
