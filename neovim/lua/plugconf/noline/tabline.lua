local M = {}

local Palette = require("palette")

local Tabline = require("noline.source.tabline")
local Component = require("noline.utility.component")
local Highlight = require("noline.utility.highlight")

local State = require("plugconf.noline.state")
local Decorator = require("plugconf.noline.decorator")
local Runner = require("plugconf.noline.runner")
local Tab = require("plugconf.noline.tab")
local VCS = require("plugconf.noline.vcs")

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
    local color = 0
    local bg = palette.bgm

    Highlight.create("NRunner")
    Highlight.link("NRunnerR", "NeuBlueBold")
    Highlight.link("NRunnerS", "NeuGreenBold")
    Highlight.link("NRunnerI", "NeuYellowBold")
    Highlight.link("NRunnerF", "NeuRedBold")

    math.randomseed(os.time())

    color = math.random(#colors)
    Highlight.create("NTab", colors[color], bg, "bold,inverse")
    Highlight.create("NTabL", colors[color], bg, "bold")
    Highlight.link("NTabR", "NTabL")

    color = math.random(#colors)
    Highlight.create("NTabNC", colors[color], bg)

    color = math.random(#colors)
    Highlight.create("NVcs", colors[color], bg)

    Highlight.create("NClose", palette.red, palette.fgs, "bold,inverse")
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

  M.render()
  M.update()
end

return M
