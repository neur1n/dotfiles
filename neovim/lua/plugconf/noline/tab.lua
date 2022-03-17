local api = vim.api

local M ={}

local File = require("noline.source.file")
local Component = require("noline.utility.component")

function M.current(l_decor, r_decor)
  local expr = ""
  local text = ""
  local limit = vim.o.columns / 3

  text = File.full_path()

  if api.nvim_buf_get_name(0) == ""or  api.nvim_strwidth(text) >= limit then
    text = File.full_dir()

    if api.nvim_strwidth(text) >= limit then
      text = File.name()
    end
  end

  expr = api.nvim_tabpage_get_number(0) .. " " .. text

  return Component.decorate(expr, l_decor, r_decor)
end

function M.not_current(separator, l_decor, r_decor)
  if #api.nvim_list_tabpages() == 1 then
    return ""
  end

  local list = {}
  local buf = ""
  local sep = separator and separator or "|"
  local ctab = api.nvim_get_current_tabpage()

  for number, handle in pairs(api.nvim_list_tabpages()) do
    if handle ~= ctab then
      buf = api.nvim_win_get_buf(api.nvim_tabpage_get_win(handle))
      buf = vim.fn.fnamemodify(api.nvim_buf_get_name(buf), ":t")
      list[#list+1] = number .. " " .. buf
    end
  end

  return Component.decorate(table.concat(list, sep), l_decor, r_decor)
end

return M
