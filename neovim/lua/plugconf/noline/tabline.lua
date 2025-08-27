local M = {}

local Palette = require("palette")

local Component = require("noline.component")
local Tabline = require("noline.tabline")

local State = require("plugconf.noline.state")
local Decorator = require("plugconf.noline.decorator")
local Runner = require("plugconf.noline.runner")
local Tab = require("plugconf.noline.tab")
local VCS = require("plugconf.noline.vcs")

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

function M.render(color)
  if not State.tal_initialized then
    local palette = Palette.get(Palette.current())
    local bg = palette.bgm
    local c = 0

    math.randomseed(os.time())

    c = math.random(#color)
    vim.api.nvim_set_hl(0, "NTab", {
      fg = color[c].g, bg = bg.g, bold = true, reverse = true,
      ctermfg = color[c].c, ctermbg = bg.c, cterm = {bold = true, reverse = true},
      force = true
    })
    vim.api.nvim_set_hl(0, "NTabL", {
      fg = color[c].g, bg = bg.g, bold = true,
      ctermfg = color[c].c, ctermbg = bg.c, cterm = {bold = true},
      force = true
    })
    vim.api.nvim_set_hl(0, "NTabR", {link = "NTabL", force = true})

    c = math.random(#color)
    vim.api.nvim_set_hl(0, "NTabNC", {
      fg = color[c].g, bg = bg.g,
      ctermfg = color[c].c, ctermbg = bg.c,
      force = true
    })

    c = math.random(#color)
    vim.api.nvim_set_hl(0, "NVcs", {
      fg = color[c].g, bg = bg.g,
      ctermfg = color[c].c, ctermbg = bg.c,
      force = true
    })

    vim.api.nvim_set_hl(0, "NClose", {
      fg = palette.red.g, bg = palette.fgs.g, bold = true, reverse = true,
      ctermfg = palette.red.c, ctermbg = palette.fgs.c, cterm = {bold = true, reverse = true},
      force = true
    })
  end
end

local decor = Decorator.get()

function M.setup()
  local expr = ""

  expr = expr .. Component.create(decor["left"], "NTabL")
  expr = expr .. Component.create(Tab.current(), "NTab")
  expr = expr .. Component.create(decor["right"], "NTabR")

  expr = expr .. Component.create(Tab.not_current(decor["sep"], " ", " "), "NTabNC")

  expr = expr .. "%="

  local runner = Runner.status()
  if runner ~= "" then
    expr = expr .. Component.create(runner, "NRunner")
  end

  expr = expr .. "%="

  expr = expr .. Component.create({VCS.get("gitsigns", ""), "", " "}, "NVcs")

  expr = expr .. Component.create(Tabline.button("", " ", " "), "NClose")

  return expr
end

function M.update()
  vim.api.nvim_set_option("tabline", "%{%v:lua.require'plugconf.noline.tabline'.setup()%}")
  State.tal_initialized = true
end

function M.redraw()
  State.tal_initialized = false

  local color = get_color()
  M.render(color)
  M.update()
end

return M
