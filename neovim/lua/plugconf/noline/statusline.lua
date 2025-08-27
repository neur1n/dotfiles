local M = {}

local Palette = require("palette")

local Component = require("noline.component")
local Buffer = require("noline.buffer")
local Edit = require("noline.edit")
local File = require("noline.file")

local State = require("plugconf.noline.state")
local Decorator = require("plugconf.noline.decorator")
local Diagnosis = require("plugconf.noline.diagnosis")
local Mode = require("plugconf.noline.mode")
local Tag = require("plugconf.noline.tag")

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
  if not State.stl_initialized then
    local palette = Palette.get(Palette.current())
    local bg = palette.bgm
    local c = 0

    math.randomseed(os.time())

    c = math.random(#color)
    vim.api.nvim_set_hl(0, "NStart", {
      fg = color[c].g, bg = bg.g,
      ctermfg = color[c].c, ctermbg = bg.c,
      force = true
    })
    vim.api.nvim_set_hl(0, "NEnd", {
      fg = color[c].g, bg = bg.g,
      ctermfg = color[c].c, ctermbg = bg.c,
      force = true
    })

    c = math.random(#color)
    vim.api.nvim_set_hl(0, "NModeN", {
      fg = color[c].g, bg = bg.g, bold = true,
      ctermfg = color[c].c, ctermbg = bg.c, cterm = {bold = true},
      force = true
    })

    c = math.random(#color)
    vim.api.nvim_set_hl(0, "NModeV", {
      fg = color[c].g, bg = bg.g, bold = true,
      ctermfg = color[c].c, ctermbg = bg.c, cterm = {bold = true},
      force = true
    })

    c = math.random(#color)
    vim.api.nvim_set_hl(0, "NModeI", {
      fg = color[c].g, bg = bg.g, bold = true,
      ctermfg = color[c].c, ctermbg = bg.c, cterm = {bold = true},
      force = true
    })

    c = math.random(#color)
    vim.api.nvim_set_hl(0, "NModeR", {
      fg = color[c].g, bg = bg.g, bold = true,
      ctermfg = color[c].c, ctermbg = bg.c, cterm = {bold = true},
      force = true
    })

    c = math.random(#color)
    vim.api.nvim_set_hl(0, "NModeC", {
      fg = color[c].g, bg = bg.g, bold = true,
      ctermfg = color[c].c, ctermbg = bg.c, cterm = {bold = true},
      force = true
    })

    c = math.random(#color)
    vim.api.nvim_set_hl(0, "NNameD", {
      fg = color[c].g, bg = bg.g,
      ctermfg = color[c].c, ctermbg = bg.c,
      force = true
    })
    vim.api.nvim_set_hl(0, "NName", {
      fg = color[c].g, bg = bg.g, reverse = true,
      ctermfg = color[c].c, ctermbg = bg.c, cterm = {reverse = true},
      force = true
    })
    vim.api.nvim_set_hl(0, "NEdit", {link = "NName"})

    vim.api.nvim_set_hl(0, "NTag", {
      fg = palette.fgm.g, bg = bg.g, bold = true,
      ctermfg = palette.fgm.c, ctermbg = bg.c, cterm = {bold = true},
      force = true
    })

    vim.api.nvim_set_hl(0, "NDiagE", {
      fg = palette.red.g, bg = bg.g,
      ctermfg = palette.red.c, ctermbg = bg.c,
      force = true
    })
    vim.api.nvim_set_hl(0, "NDiagW", {
      fg = palette.yellow.g, bg = bg.g,
      ctermfg = palette.yellow.c, ctermbg = bg.c,
      force = true
    })
    vim.api.nvim_set_hl(0, "NDiagH", {
      fg = palette.blue.g, bg = bg.g,
      ctermfg = palette.blue.c, ctermbg = bg.c,
      force = true
    })
    vim.api.nvim_set_hl(0, "NDiagI", {
      fg = palette.green.g, bg = bg.g,
      ctermfg = palette.green.c, ctermbg = bg.c,
      force = true
    })

    c = math.random(#color)
    vim.api.nvim_set_hl(0, "NFileInfoD", {
      fg = color[c].g, bg = bg.g,
      ctermfg = color[c].c, ctermbg = bg.c,
      force = true
    })
    vim.api.nvim_set_hl(0, "NFileInfo", {
      fg = color[c].g, bg = bg.g, reverse = true,
      ctermfg = color[c].c, ctermbg = bg.c, cterm = {reverse = true},
      force = true
    })

    c = math.random(#color)
    vim.api.nvim_set_hl(0, "NRuler", {
      fg = color[c].g, bg = bg.g,
      ctermfg = color[c].c, ctermbg = bg.c,
      force = true
    })
  end

  Mode.highlight()
end

function M.render_nc(color)
  if not State.stl_initialized then
    local palette = Palette.get(Palette.current())
    local bg = palette.bgm
    local c = 0

    math.randomseed(os.time())

    c = math.random(#color)
    vim.api.nvim_set_hl(0, "NNameNC", {
      fg = color[c].g, bg = bg.g,
      ctermfg = color[c].c, ctermbg = bg.c,
      force = true
    })

    vim.api.nvim_set_hl(0, "NEditNC", {
      fg = palette.red.g, bg = bg.g,
      ctermfg = palette.red.c, ctermbg = bg.c,
      force = true
    })

    vim.api.nvim_set_hl(0, "NTagNC", {
      fg = palette.fgm.g, bg = bg.g, bold = true,
      ctermfg = palette.fgm.c, ctermbg = bg.c, cterm = {bold = true},
      force = true
    })

    vim.api.nvim_set_hl(0, "NDiagENC", {
      fg = palette.red.g, bg = bg.g,
      ctermfg = palette.red.c, ctermbg = bg.c,
      force = true
    })
    vim.api.nvim_set_hl(0, "NDiagWNC", {
      fg = palette.yellow.g, bg = bg.g,
      ctermfg = palette.yellow.c, ctermbg = bg.c,
      force = true
    })
    vim.api.nvim_set_hl(0, "NDiagHNC", {
      fg = palette.blue.g, bg = bg.g,
      ctermfg = palette.blue.c, ctermbg = bg.c,
      force = true
    })
    vim.api.nvim_set_hl(0, "NDiagINC", {
      fg = palette.green.g, bg = bg.g,
      ctermfg = palette.green.c, ctermbg = bg.c,
      force = true
    })

    c = math.random(#color)
    vim.api.nvim_set_hl(0, "NFileInfoNC", {
      fg = color[c].g, bg = bg.g,
      ctermfg = color[c].c, ctermbg = bg.c,
      force = true
    })

    c = math.random(#color)
    vim.api.nvim_set_hl(0, "NRulerNC", {
      fg = color[c].g, bg = bg.g,
      ctermfg = color[c].c, ctermbg = bg.c,
      force = true
    })
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

  local color = get_color()
  M.render_c(color)
  M.render_nc(color)
  M.update()
end

return M
