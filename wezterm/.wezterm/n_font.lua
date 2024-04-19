local M = {}

local fonts = {
  {["name"] = "3270 Nerd Font Mono"           , ["size"] = 12},
  {["name"] = "Agave Nerd Font Mono"          , ["size"] = 13},
  {["name"] = "CaskaydiaCove Nerd Font Mono"  , ["size"] = 12},
  {["name"] = "ComicShannsMono Nerd Font Mono", ["size"] = 12},
  {["name"] = "DaddyTimeMono Nerd Font Mono"  , ["size"] = 12},
  {["name"] = "EnvyCodeR Nerd Font Mono"      , ["size"] = 12},
  {["name"] = "FantasqueSansM Nerd Font Mono" , ["size"] = 13},
  {["name"] = "FiraCode Nerd Font Mono"       , ["size"] = 11},
  {["name"] = "GohuFont uni11 Nerd Font Mono" , ["size"] = 12},
  {["name"] = "GohuFont uni14 Nerd Font Mono" , ["size"] = 12},
  {["name"] = "Hurmit Nerd Font Mono"         , ["size"] = 11},
  {["name"] = "IntoneMono Nerd Font Mono"     , ["size"] = 11},
  {["name"] = "JetBrainsMono Nerd Font Mono"  , ["size"] = 11},
  {["name"] = "Maple Mono NF"                 , ["size"] = 11},
  {["name"] = "MonaspiceAr Nerd Font Mono"    , ["size"] = 11},
  {["name"] = "MonaspiceKr Nerd Font Mono"    , ["size"] = 11},
  {["name"] = "MonaspiceNe Nerd Font Mono"    , ["size"] = 11},
  {["name"] = "MonaspiceRn Nerd Font Mono"    , ["size"] = 11},
  {["name"] = "MonaspiceXe Nerd Font Mono"    , ["size"] = 11},
  {["name"] = "Monocraft Nerd Font"           , ["size"] = 10},
  {["name"] = "Monofur Nerd Font Mono"        , ["size"] = 13},
  {["name"] = "ProFontWindows Nerd Font Mono" , ["size"] = 13},
  {["name"] = "ProggyClean Nerd Font Mono"    , ["size"] = 16},
  {["name"] = "RecMonoCasual Nerd Font Mono"  , ["size"] = 12},
  {["name"] = "SpaceMono Nerd Font Mono"      , ["size"] = 11},
}

function M.get()
  return fonts[math.random(#fonts)]
end

return M
