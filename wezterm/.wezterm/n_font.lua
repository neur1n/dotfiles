local M = {}

local fonts = {
  {["name"] = "3270 Nerd Font Mono"           , ["size"] = 12},
  {["name"] = "Agave Nerd Font Mono"          , ["size"] = 13},
  {["name"] = "CaskaydiaCove NFM"             , ["size"] = 12},
  {["name"] = "ComicShannsMono Nerd Font Mono", ["size"] = 12},
  {["name"] = "FantasqueSansM Nerd Font Mono" , ["size"] = 13},
  {["name"] = "FiraCode Nerd Font Mono Ret"   , ["size"] = 11},
  {["name"] = "GohuFont uni11 Nerd Font Mono" , ["size"] = 12},
  {["name"] = "GohuFont uni14 Nerd Font Mono" , ["size"] = 12},
  {["name"] = "Hurmit Nerd Font Mono"         , ["size"] = 11},
  {["name"] = "Input Nerd Font Mono"          , ["size"] = 12},
  {["name"] = "JetBrainsMono NFM"             , ["size"] = 11},
  {["name"] = "Maple Mono NF"                 , ["size"] = 11},
  {["name"] = "Monocraft Nerd Font"           , ["size"] = 10},
  {["name"] = "Monofur Nerd Font Mono"        , ["size"] = 13},
  {["name"] = "OpenDyslexicM Nerd Font Mono"  , ["size"] =  9},
  {["name"] = "ProFontWindows Nerd Font Mono" , ["size"] = 13},
  {["name"] = "ProggyCleanSZ Nerd Font Mono"  , ["size"] = 16},
  {["name"] = "SpaceMono Nerd Font Mono"      , ["size"] = 11},
}

function M.get()
  return fonts[math.random(#fonts)]
end

return M
