local Wezterm = require("wezterm")

local M = {}

local fonts = {
  {["name"] = "0xProto Nerd Font Mono"        , ["size"] = 10},
  {["name"] = "Agave Nerd Font Mono"          , ["size"] = 13},
  {["name"] = "AtkynsonMono NFM"              , ["size"] = 10},
  {["name"] = "CaskaydiaCove Nerd Font Mono"  , ["size"] = 12},
  {["name"] = "ComicShannsMono Nerd Font Mono", ["size"] = 12},
  {["name"] = "DepartureMono Nerd Font Mono"  , ["size"] = 10},
  {["name"] = "FantasqueSansM Nerd Font Mono" , ["size"] = 13},
  {["name"] = "FiraCode Nerd Font Mono Ret"   , ["size"] = 11},
  {["name"] = "GohuFont uni11 Nerd Font Mono" , ["size"] = 12.5},
  {["name"] = "Hurmit Nerd Font Mono"         , ["size"] = 11},
  {["name"] = "IntoneMono Nerd Font Mono"     , ["size"] = 11},
  {["name"] = "JetBrainsMono Nerd Font Mono"  , ["size"] = 11},
  {["name"] = "Maple Mono NF"                 , ["size"] = 11},
  {["name"] = "ProFontWindows Nerd Font Mono" , ["size"] = 13},
  {["name"] = "ProggyClean Nerd Font Mono"    , ["size"] = 16},
  {["name"] = "RecMonoCasual Nerd Font Mono"  , ["size"] = 11},
  {["name"] = "SpaceMono Nerd Font Mono"      , ["size"] = 11},
}

local function selector_list()
  local list = {}
  local i = 1

  for _, v in ipairs(fonts) do
    local item = {}
    item["label"] = v.name
    item["id"] = Wezterm.json_encode(v)
    list[i] = item
    i = i + 1
  end

  return list
end

function M.get()
  return fonts[math.random(#fonts)]
end

function M.select()
  local offset = 0
  if Wezterm.gui.screens().active.width > 2560 then
    offset = 4
  elseif Wezterm.gui.screens().active.width <= 1920 then
    offset = -2
  end

  return Wezterm.action.InputSelector{
    action = Wezterm.action_callback(function(window, pane, id, label)
      local font = Wezterm.json_parse(id)

      window:set_config_overrides({
        font = Wezterm.font(font.name),
        font_size = font.size + offset
      })
    end),
    choices = selector_list(),
    fuzzy = true,
    title = "Fonts"
  }
end

Wezterm.on("select-font", function(window, pane)
  window:perform_action(M.select(), pane)
end)

return M
