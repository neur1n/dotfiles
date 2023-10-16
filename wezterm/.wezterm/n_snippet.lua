local Wezterm = require("wezterm")

local Pane = require("n_pane")

local M = {}

local function load(path)
  local f= io.open(path, "r")
  if f == nil then
    return {}
  end

  local json = Wezterm.json_parse(f:read("a"))
  f:close()

  local list = {}
  local i = 1

  for k, v in pairs(json) do
    local item  ={}
    item["label"] = k
    item["id"] = v
    list[i] = item
    i = i + 1
  end

  return list
end

function M.select(path)
  local list = load(path)

  return Wezterm.action.InputSelector{
    action = Wezterm.action_callback(function(window, pane, id, label)
      local snippet = Wezterm.json_parse(id)
      local panes = nil

      if snippet.spawn == true then
        local _, p, _ = window:mux_window():spawn_tab{}
        panes = Pane.split(p, snippet.split)
      else
        panes = Pane.split(pane, snippet.split)
      end

      local cmd = ""
      local ms = 0

      for _, e in ipairs(snippet.event) do
        for _, p in pairs(panes) do
          cmd, ms = next(e)
          p:send_text(cmd .. "\r")
          Wezterm.sleep_ms(ms)
        end
      end
    end),
    choices = list,
    fuzzy = true,
    title = "Snippets"
  }
end

M.path = Wezterm.config_dir .. "/.wezterm/snippet_vault.json"

Wezterm.on(M.path, function(window, pane)
  window:perform_action(M.select(M.path), pane)
end)

return M
