local api = vim.api

local M = {}

local Tabline = require("noline.source.tabline")
local Component = require("noline.utility.component")
local Highlight = require("noline.utility.highlight")


local State = require("plugconf.noline.state")
local Decorator = require("plugconf.noline.decorator")
local Palette = require("plugconf.noline.palette")
local Tab = require("plugconf.noline.tab")

local palette = Palette.get()
local colors = {
  palette.red,
  palette.orange,
  palette.yellow,
  palette.green,
  palette.blue,
  palette.cyan,
  palette.purple,
}

function M.render()
  if not State.tal_initialized then
    local color = ""
    local bg = palette.bgm

    math.randomseed(os.time())

    color = math.random(#colors)
    Highlight.create("NTab", colors[color], bg, "bold,inverse")
    Highlight.create("NTabL", colors[color], bg, "bold")
    Highlight.link("NTabR", "NTabL")

    color = math.random(#colors)
    Highlight.create("NTab_nc", colors[color], bg)

    Highlight.create("NClose", palette.red, palette.fgs, "bold,inverse")
  end
end

local decor = Decorator.get()

function M.setup()
  local expr = ""

  expr = expr .. Component.create(decor["left"], "NTabL")
  expr = expr .. Component.create(Tab.current(), "NTab")
  expr = expr .. Component.create(decor["right"], "NTabR")

  expr = expr .. Component.create(Tab.not_current(decor["sep"], " ", " "), "NTab_nc")

  expr = expr .. "%="

  expr = expr .. Component.create(Tabline.button("", " ", " "), "NClose")

  return expr
end

function M.update()
  api.nvim_set_option("tabline", "%{%v:lua.require'plugconf.noline.tabline'.setup()%}")
  State.tal_initialized = true
end

function M.redraw()
  palette = Palette.get()
  State.tal_initialized = false

  M.render()
  M.update()
end

return M
