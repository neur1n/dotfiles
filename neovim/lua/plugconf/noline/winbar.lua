local api = vim.api

local M = {}

local Component = require("noline.utility.component")
local Highlight = require("noline.utility.highlight")

local State = require("plugconf.noline.state")
local Palette = require("plugconf.noline.palette")
local Tag = require("plugconf.noline.tag")

local palette = Palette.get()

function M.render_c()
  if not State.wbr_initialized then
    Highlight.create("NTag",  palette.fgm, palette.bgm, "bold")
  end
end

function M.render_nc()
  if not State.wbr_initialized then
    Highlight.create("NTag_nc",  palette.grays, palette.bgm, "bold")
  end
end

function M.setup_c()
  local expr = ""

  expr = expr .. "%=%<"

  expr = expr .. Component.create(Tag.get(""), "NTag")

  expr = expr .. "%="

  return expr
end

function M.setup_nc()
  local expr = ""

  expr = expr .. "%=%<"

  expr = expr .. Component.create(Tag.get(""), "NTag_nc")

  expr = expr .. "%="

  return expr
end

function M.update()
  for number, handle in pairs(api.nvim_tabpage_list_wins(0)) do
    if vim.fn.win_gettype() == "" and vim.fn.winheight(number) >= 2 then
      if number == api.nvim_win_get_number(0) then
        api.nvim_win_set_option(handle, "winbar",
          "%{%v:lua.require'plugconf.noline.winbar'.setup_c()%}")
      else
        api.nvim_win_set_option(handle, "winbar",
          "%{%v:lua.require'plugconf.noline.winbar'.setup_nc()%}")
      end
    end
  end

  State.wbr_initialized = true
end

function M.redraw()
  palette = Palette.get()
  State.wbr_initialized = false

  M.render_c()
  M.render_nc()
  M.update()
end

return M
