local M = {}

local fonts = {
  {name = "3270 Nerd Font Mono"           , size = 12},
  {name = "Agave Nerd Font Mono"          , size = 13},
  {name = "CaskaydiaCove Nerd Font Mono"  , size = 12},
  {name = "ComicShannsMono Nerd Font Mono", size = 12},
  {name = "DaddyTimeMono Nerd Font Mono"  , size = 12},
  {name = "EnvyCodeR Nerd Font Mono"      , size = 12},
  {name = "FantasqueSansM Nerd Font Mono" , size = 13},
  {name = "FiraCode Nerd Font Mono"       , size = 11},
  {name = "GohuFont uni11 Nerd Font Mono" , size = 12},
  {name = "GohuFont uni14 Nerd Font Mono" , size = 12},
  {name = "Hurmit Nerd Font Mono"         , size = 11},
  {name = "IntoneMono Nerd Font Mono"     , size = 11},
  {name = "JetBrainsMono Nerd Font Mono"  , size = 11},
  {name = "Maple Mono NF"                 , size = 11},
  {name = "MonaspiceAr Nerd Font Mono"    , size = 11},
  {name = "MonaspiceKr Nerd Font Mono"    , size = 11},
  {name = "MonaspiceNe Nerd Font Mono"    , size = 11},
  {name = "MonaspiceRn Nerd Font Mono"    , size = 11},
  {name = "MonaspiceXe Nerd Font Mono"    , size = 11},
  {name = "Monocraft Nerd Font"           , size = 10},
  {name = "Monofur Nerd Font Mono"        , size = 13},
  {name = "ProFontWindows Nerd Font Mono" , size = 13},
  {name = "ProggyClean Nerd Font Mono"    , size = 16},
  {name = "RecMonoCasual Nerd Font Mono"  , size = 12},
  {name = "SpaceMono Nerd Font Mono"      , size = 11},
}

local options = {
  backspace = "indent,start",
  colorcolumn = "80",
  completeopt = "menu,menuone,noselect",
  cursorline = true,
  foldmethod = "marker",
  foldlevelstart = 99,
  laststatus = 2,
  list = true,
  listchars = "tab:⇥·,trail:·,nbsp:␣,extends:»,precedes:«",
  mouse = "a",
  mousemodel = "popup",
  number = true,
  showmode = false,
  pumblend = 20,
  winblend = 20,
  signcolumn = "yes",
  splitbelow = true,
  splitright = true,
  termguicolors = true,
  updatetime = 500,

  -- File encoding and format
  encoding = "utf-8",
  fileencoding = "utf-8",
  fileformat = "unix",
  fileformats = "unix,dos",

  -- Tab size
  expandtab = true,
  shiftwidth = 2,
  softtabstop = 2,
  tabstop = 2,
}

function M.set_font()
  local cmd = ""
  if vim.fn.has("win32") == 1 then
    cmd = "wmic path Win32_VideoController get CurrentHorizontalResolution"
  else
    cmd = "xdpyinfo | grep dimensions"
  end

  local width = 0
  local handle = io.popen(cmd)
  if handle then
    local output = handle:read("*a")
    handle:close()
    width = tonumber(output:match("(%d+)")) or 2560
  end

  math.randomseed(os.time())
  local font = fonts[math.random(#fonts)]
  if width > 2560 then
    vim.o.guifont = font.name .. ":" .. (font.size + 2)
  elseif width < 2560 then
    vim.o.guifont = font.name .. ":" .. (font.size - 2)
  end
end

function M.setup()
  for k, v in pairs(options) do
    vim.o[k] = v
  end

  M.set_font()
end

return M
