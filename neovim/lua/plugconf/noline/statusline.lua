local api = vim.api

local M = {}

local Buffer = require("noline.source.buffer")
local Edit = require("noline.source.edit")
local File = require("noline.source.file")
local Component = require("noline.utility.component")
local Highlight = require("noline.utility.highlight")

local State = require("plugconf.noline.state")
local Decorator = require("plugconf.noline.decorator")
local Diagnosis = require("plugconf.noline.diagnosis")
local Mode = require("plugconf.noline.mode")
local Palette = require("plugconf.noline.palette")
local Tag = require("plugconf.noline.tag")
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

function M.render_c()
  if not State.stl_initialized then
    local color = ""

    math.randomseed(os.time())

    color = math.random(#colors)
    Highlight.create("NStart", colors[color], palette.bgh)
    Highlight.create("NEnd"  , colors[color], palette.bgh)

    color = math.random(#colors)
    Highlight.create("NModeN", colors[color], palette.bgh, "bold")

    color = math.random(#colors)
    Highlight.create("NModeV", colors[color], palette.bgh, "bold")

    color = math.random(#colors)
    Highlight.create("NModeI", colors[color], palette.bgh, "bold")

    color = math.random(#colors)
    Highlight.create("NModeR", colors[color], palette.bgh, "bold")

    color = math.random(#colors)
    Highlight.create("NModeC", colors[color], palette.bgh, "bold")

    color = math.random(#colors)
    Highlight.create("NName",  colors[color], palette.bgh, "inverse")
    Highlight.create("NNameL",  colors[color], palette.bgh)
    Highlight.link("NNameR", "NNameL")

    Highlight.create("NEdit",  palette.red, palette.bgh)

    Highlight.create("NTag",  palette.fgm, palette.bgh, "bold")

    Highlight.create("NDiagE", palette.red, palette.bgh)
    Highlight.create("NDiagW", palette.yellow, palette.bgh)
    Highlight.create("NDiagH", palette.blue, palette.bgh)
    Highlight.create("NDiagI", palette.green, palette.bgh)

    color = math.random(#colors)
    Highlight.create("NFileInfo",  colors[color], palette.bgh, "inverse")
    Highlight.create("NFileInfoL", colors[color], palette.bgh)
    Highlight.link("NFileInfoR", "NFileInfoL")

    color = math.random(#colors)
    Highlight.create("NRuler", colors[color], palette.bgh)

    color = math.random(#colors)
    Highlight.create("NVcs", colors[color], palette.bgh)
  end

  Mode.highlight()
end

function M.render_nc()
  if not State.stl_initialized then
    local color = ""

    math.randomseed(os.time())

    color = math.random(#colors)
    Highlight.create("NName_nc",  colors[color], palette.bgh)

    Highlight.create("NEdit",  palette.red, palette.bgh)

    Highlight.create("NTag",  palette.fgm, palette.bgh, "bold")

    Highlight.create("NDiagE", palette.red, palette.bgh)
    Highlight.create("NDiagW", palette.yellow, palette.bgh)
    Highlight.create("NDiagH", palette.blue, palette.bgh)
    Highlight.create("NDiagI", palette.green, palette.bgh)

    color = math.random(#colors)
    Highlight.create("NFileInfo_nc",  colors[color], palette.bgh)

    color = math.random(#colors)
    Highlight.create("NRuler", colors[color], palette.bgh)

    color = math.random(#colors)
    Highlight.create("NVcs", colors[color], palette.bgh)
  end
end

local glyphs = {
  ["c"] = {["md"] = "", ["ma"] = "", ["ro"] = "", ["e"] = "", ["w"] = "", ["h"] = "", ["i"] = ""},
  ["nc"] = {["md"] = "", ["ma"] = "", ["ro"] = "", ["e"] = "", ["w"] = "", ["h"] = "ﬤ", ["i"] = ""},
}

local decor = Decorator.get()
local glyph = {}

function M.setup_c()
  Mode.highlight()

  glyph = glyphs.c

  local expr = ""

  expr = expr .. Component.create(decor["right"], "NStart")

  expr = expr .. Component.create(Mode.get(" "), "NMode")
  expr = expr .. Component.create(Edit.paste("P", decor["sep"]), "NMode")
  expr = expr .. Component.create(Edit.spell("S", decor["sep"]), "NMode")

  expr = expr .. Component.create({" ", decor["left"]}, "NNameL")
  expr = expr .. Component.create({Buffer.number(), decor["sep"], File.name()}, "NName")
  expr = expr .. Component.create(decor["right"], "NNameR")

  expr = expr .. Component.create({
    Edit.modified(glyph.md, " "),
    Edit.modifiable(glyph.ma, " "),
    Edit.readonly(glyph.ro, " ")}, "NEdit")

  expr = expr .. Component.create(Diagnosis.info("coc", "error",       glyph.e, " "), "NDiagE")
  expr = expr .. Component.create(Diagnosis.info("coc", "warning",     glyph.w, " "), "NDiagW")
  expr = expr .. Component.create(Diagnosis.info("coc", "hint",        glyph.h, " "), "NDiagH")
  expr = expr .. Component.create(Diagnosis.info("coc", "information", glyph.i, " "), "NDiagI")

  expr = expr .. "%="

  expr = expr .. Component.create(Tag.get("", " "), "NTag")

  expr = expr .. "%="

  expr = expr .. Component.create(VCS.get("coc", "שׂ"), "NVcs")

  expr = expr .. Component.create({" ", decor["left"]}, "NFileInfoL")
  expr = expr .. Component.create({File.encoding(), decor["sep"], File.format()}, "NFileInfo")
  expr = expr .. Component.create({decor["right"], " "}, "NFileInfoR")

  expr = expr .. Component.create({
    Buffer.line(4), decor["sep"],
    Buffer.line_count(), ":",
    Buffer.column("v", -3), " "}, "NRuler")

  expr = expr .. Component.create(decor["left"], "NEnd")

  return expr
end

function M.setup_nc()
  glyph = glyphs.nc

  local expr = ""

  expr = expr .. Component.create(Mode.get(" "), "NMode")
  expr = expr .. Component.create(Edit.paste("P", decor["sep"]), "NMode")
  expr = expr .. Component.create(Edit.spell("S", decor["sep"]), "NMode")

  expr = expr .. Component.create({" ", Buffer.number(), decor["sep"], File.name()}, "NName_nc")

  expr = expr .. Component.create({
    Edit.modified(glyph.md, " "),
    Edit.modifiable(glyph.ma, " "),
    Edit.readonly(glyph.ro, " ")}, "NEdit")

  expr = expr .. Component.create(Diagnosis.info("coc", "error",       glyph.e, " "), "NDiagE")
  expr = expr .. Component.create(Diagnosis.info("coc", "warning",     glyph.w, " "), "NDiagW")
  expr = expr .. Component.create(Diagnosis.info("coc", "hint",        glyph.h, " "), "NDiagH")
  expr = expr .. Component.create(Diagnosis.info("coc", "information", glyph.i, " "), "NDiagI")

  expr = expr .. "%="

  expr = expr .. Component.create(Tag.get("", " "), "NTag")

  expr = expr .. "%="

  expr = expr .. Component.create({VCS.get("coc", "שׂ"), " "}, "NVcs")

  expr = expr .. Component.create({File.encoding("", decor["sep"]), File.format(), " "}, "NFileInfo_nc")

  expr = expr .. Component.create({
    Buffer.line(4), decor["sep"],
    Buffer.line_count(), ":",
    Buffer.column("v", -3), " "}, "NRuler")

  return expr
end

function M.update()
  -- local count = vim.fn.winnr("$")

  -- if count == 1 then
  --   api.nvim_win_set_option(0, "statusline",
  --     "%{%v:lua.require'plugconf.noline.statusline'.setup_c()%}")
  -- else
  --   for i = 1, count do
  --     if vim.fn.win_gettype() == "" then
  --       if i == api.nvim_win_get_number(0) then
  --         api.nvim_win_set_option(vim.fn.win_getid(i), "statusline",
  --           "%{%v:lua.require'plugconf.noline.statusline'.setup_c()%}")
  --       else
  --         api.nvim_win_set_option(vim.fn.win_getid(i), "statusline",
  --           "%{%v:lua.require'plugconf.noline.statusline'.setup_nc()%}")
  --       end
  --     end
  --   end
  -- end

  for number, handle in pairs(api.nvim_tabpage_list_wins(0)) do
    if vim.fn.win_gettype() == "" then
      if number == api.nvim_win_get_number(0) then
        api.nvim_win_set_option(handle, "statusline",
          "%{%v:lua.require'plugconf.noline.statusline'.setup_c()%}")
      else
        api.nvim_win_set_option(handle, "statusline",
          "%{%v:lua.require'plugconf.noline.statusline'.setup_nc()%}")
      end
    end
  end

  State.stl_initialized = true
end

return M