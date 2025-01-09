local M = {}

local Palette = require("palette")

local Buffer = require("noline.source.buffer")
local Edit = require("noline.source.edit")
local File = require("noline.source.file")
local Component = require("noline.utility.component")
local Highlight = require("noline.utility.highlight")

local State = require("plugconf.noline.state")
local Decorator = require("plugconf.noline.decorator")
local Diagnosis = require("plugconf.noline.diagnosis")
local Mode = require("plugconf.noline.mode")
local Tag = require("plugconf.noline.tag")

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

function M.render_c()
  if not State.stl_initialized then
    local color = 0
    local bg = palette.bgm

    math.randomseed(os.time())

    color = math.random(#colors)
    Highlight.create("NStart", colors[color], bg)
    Highlight.create("NEnd"  , colors[color], bg)

    color = math.random(#colors)
    Highlight.create("NModeN", colors[color], bg, "bold")

    color = math.random(#colors)
    Highlight.create("NModeV", colors[color], bg, "bold")

    color = math.random(#colors)
    Highlight.create("NModeI", colors[color], bg, "bold")

    color = math.random(#colors)
    Highlight.create("NModeR", colors[color], bg, "bold")

    color = math.random(#colors)
    Highlight.create("NModeC", colors[color], bg, "bold")

    color = math.random(#colors)
    Highlight.create("NNameD", colors[color], bg)
    Highlight.create("NName", colors[color], bg, "inverse")
    Highlight.link("NEdit", "NName")

    Highlight.create("NTag", palette.fgm, bg, "bold")

    Highlight.create("NDiagE", palette.red, bg)
    Highlight.create("NDiagW", palette.yellow, bg)
    Highlight.create("NDiagH", palette.blue, bg)
    Highlight.create("NDiagI", palette.green, bg)

    color = math.random(#colors)
    Highlight.create("NFileInfoD", colors[color], bg)
    Highlight.create("NFileInfo",  colors[color], bg, "inverse")

    color = math.random(#colors)
    Highlight.create("NRuler", colors[color], bg)
  end

  Mode.highlight()
end

function M.render_nc()
  if not State.stl_initialized then
    local color = 0
    local bg = palette.bgs

    math.randomseed(os.time())

    color = math.random(#colors)
    Highlight.create("NNameNC", colors[color], bg)

    Highlight.create("NEditNC", palette.red, bg)

    Highlight.create("NTagNC", palette.fgm, bg, "bold")

    Highlight.create("NDiagENC", palette.red, bg)
    Highlight.create("NDiagWNC", palette.yellow, bg)
    Highlight.create("NDiagHNC", palette.blue, bg)
    Highlight.create("NDiagINC", palette.green, bg)

    color = math.random(#colors)
    Highlight.create("NFileInfoNC", colors[color], bg)

    color = math.random(#colors)
    Highlight.create("NRulerNC", colors[color], bg)
  end
end

local decor = Decorator.get()
local glyph = {
  ["md"] = "", ["ma"] = "", ["ro"] = "󰌾",
  ["e"] = "🔥", ["w"] = "⚡", ["h"] = "💡", ["i"] = "🔎"
}

function M.setup_c()
  Mode.highlight()

  local expr = ""

  expr = expr .. Component.create(decor["right"], "NStart")

  expr = expr .. Component.create(Mode.get(" "), "NMode")
  expr = expr .. Component.create(Edit.paste("P", decor["sep"]), "NMode")
  expr = expr .. Component.create(Edit.spell("S", decor["sep"]), "NMode")
  expr = expr .. Component.create(" ", "NMode")

  expr = expr .. Component.create(decor["left"], "NNameD")
  expr = expr .. Component.create({Buffer.number(), decor["sep"], File.name()}, "NName")
  expr = expr .. Component.create({
    Edit.modified(glyph.md, " "),
    Edit.modifiable(glyph.ma, " "),
    Edit.readonly(glyph.ro, " ")}, "NEdit")
  expr = expr .. Component.create(decor["right"], "NNameD")

  expr = expr .. Component.create(Diagnosis.info("lsp", vim.diagnostic.severity.ERROR, glyph.e, " "), "NDiagE")
  expr = expr .. Component.create(Diagnosis.info("lsp", vim.diagnostic.severity.WARN,  glyph.w, " "), "NDiagW")
  expr = expr .. Component.create(Diagnosis.info("lsp", vim.diagnostic.severity.HINT,  glyph.h, " "), "NDiagH")
  expr = expr .. Component.create(Diagnosis.info("lsp", vim.diagnostic.severity.INFO,  glyph.i, " "), "NDiagI")

  expr = expr .. "%=%<"

  expr = expr .. Component.create(Tag.get("📦"), "NTag")

  expr = expr .. "%="

  expr = expr .. Component.create({" ", decor["left"]}, "NFileInfoD")
  expr = expr .. Component.create({vim.o.filetype, decor["sep"], File.encoding(), decor["sep"], File.format()}, "NFileInfo")
  expr = expr .. Component.create({decor["right"], " "}, "NFileInfoD")

  expr = expr .. Component.create({
    Buffer.line(4), decor["sep"],
    Buffer.line_count(), ":",
    Buffer.column("v", -3), " "}, "NRuler")

  expr = expr .. Component.create(decor["left"], "NEnd")

  return expr
end

function M.setup_nc()
  local expr = ""

  expr = expr .. Component.create(Edit.paste("P", decor["sep"]), "NMode")
  expr = expr .. Component.create(Edit.spell("S", decor["sep"]), "NMode")

  -- NOTE: This requires the statuscolumn to be initialized first.
  expr = expr .. Component.create({"▏"}, "NStatusColumnNC")
  expr = expr .. Component.create({Buffer.number(), decor["sep"], File.name()}, "NNameNC")

  expr = expr .. Component.create({
    Edit.modified(glyph.md, " "),
    Edit.modifiable(glyph.ma, " "),
    Edit.readonly(glyph.ro, " ")}, "NEditNC")

  expr = expr .. Component.create(Diagnosis.info("lsp", vim.diagnostic.severity.ERROR, glyph.e, " "), "NDiagENC")
  expr = expr .. Component.create(Diagnosis.info("lsp", vim.diagnostic.severity.WARN,  glyph.w, " "), "NDiagWNC")
  expr = expr .. Component.create(Diagnosis.info("lsp", vim.diagnostic.severity.HINT,  glyph.h, " "), "NDiagHNC")
  expr = expr .. Component.create(Diagnosis.info("lsp", vim.diagnostic.severity.INFO,  glyph.i, " "), "NDiagINC")

  expr = expr .. "%=%<"

  expr = expr .. Component.create(Tag.get("📦"), "NTagNC")

  expr = expr .. "%="

  expr = expr .. Component.create({vim.o.filetype, File.encoding(decor["sep"], decor["sep"]), File.format(), " "}, "NFileInfoNC")

  expr = expr .. Component.create({
    Buffer.line(4), decor["sep"],
    Buffer.line_count(), ":",
    Buffer.column("v", -3), " "}, "NRulerNC")

  return expr
end

function M.update()
  for number, handle in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.fn.win_gettype() == "" then
      if number == vim.api.nvim_win_get_number(0) then
        vim.api.nvim_win_set_option(handle, "statusline",
          "%{%v:lua.require'plugconf.noline.statusline'.setup_c()%}")
      else
        vim.api.nvim_win_set_option(handle, "statusline",
          "%{%v:lua.require'plugconf.noline.statusline'.setup_nc()%}")
      end
    end
  end

  State.stl_initialized = true
end

function M.redraw()
  State.stl_initialized = false

  M.render_c()
  M.render_nc()
  M.update()
end

return M
