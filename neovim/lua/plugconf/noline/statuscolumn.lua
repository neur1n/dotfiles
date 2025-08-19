local M = {}

local Palette = require("palette")

local Component = require("noline.component")

local State = require("plugconf.noline.state")

local palette = Palette.get(Palette.current())
local colors = {
  palette.red,
  palette.orange,
  palette.yellow,
  palette.green,
  palette.blue,
  palette.cyan,
  palette.purple,
}

function M.render_c()
  if not State.stc_initializedt then
    local color = 0
    local bg = palette.bgm

    math.randomseed(os.time())

    color = math.random(#colors)
    vim.api.nvim_set_hl(0, "NStatusColumn", {
      fg = colors[color].g, bg = bg.g,
      ctermfg = colors[color].c, ctermbg = bg.c,
      force = true
    })
  end
end

function M.render_nc()
  if not State.stc_initializedt then
    local bg = palette.bgs
    vim.api.nvim_set_hl(0, "NStatusColumnNC", {
      fg = nil, bg = bg.g,
      ctermfg = nil, ctermbg = bg.c,
      force = true
    })
  end
end

function M.setup_c()
  local expr = ""

  expr = expr .. Component.create("▌", "NStatusColumn")
  expr = expr .. Component.create("%s%-l ")

  return expr
end

function M.setup_nc()
  local expr = ""

  expr = expr .. Component.create("▏", "NStatusColumnNC")
  expr = expr .. Component.create("%s%-l ")

  return expr
end

function M.update()
  for number, handle in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.fn.win_gettype() == "" then
      if number == vim.api.nvim_win_get_number(0) then
        vim.api.nvim_win_set_option(handle, "statuscolumn",
          "%{%v:lua.require'plugconf.noline.statuscolumn'.setup_c()%}")
      else
        vim.api.nvim_win_set_option(handle, "statuscolumn",
          "%{%v:lua.require'plugconf.noline.statuscolumn'.setup_nc()%}")
      end
    end
  end

  State.stc_initializedt = true
end

function M.redraw()
  State.stc_initializedt = false

  M.render_c()
  M.render_nc()
  M.update()
end

return M
