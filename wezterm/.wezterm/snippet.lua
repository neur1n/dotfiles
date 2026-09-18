local Wezterm = require("wezterm")

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

function M.select()
  local list = load(Wezterm.config_dir .. "/.wezterm/snippet.json")

  return Wezterm.action.InputSelector{
    action = Wezterm.action_callback(function(window, pane, id, label)
      local snippet = Wezterm.json_parse(id)
      pane:send_text(snippet.input)
    end),
    choices = list,
    fuzzy = true,
    title = "Snippet"
  }
end

Wezterm.on("select-snippet", function(window, pane)
  window:perform_action(M.select(), pane)
end)

return M
