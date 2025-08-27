local M = {}

local Palette = require("palette")

local Component = require("noline.component")

local State = require("plugconf.noline.state")

local function get_color()
  local palette = Palette.get(Palette.current())

  return {
    palette.red,
    palette.orange,
    palette.yellow,
    palette.green,
    palette.blue,
    palette.cyan,
    palette.purple,
  }
end

function M.render_c(color)
  if not State.stc_initializedt then
    local palette = Palette.get(Palette.current())
    local bg = palette.bgm
    local c = 0

    math.randomseed(os.time())

    c = math.random(#color)
    vim.api.nvim_set_hl(0, "NStatusColumn", {
      fg = color[c].g, bg = bg.g,
      ctermfg = color[c].c, ctermbg = bg.c,
      force = true
    })
  end
end

function M.render_nc()
  if not State.stc_initializedt then
    local palette = Palette.get(Palette.current())
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

  local color = get_color()
  M.render_c(color)
  M.render_nc()
  M.update()
end

return M
