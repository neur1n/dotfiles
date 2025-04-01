local M ={}

local File = require("noline.source.file")
local Component = require("noline.utility.component")

function M.current(l_decor, r_decor)
  local text = File.full_path()
  local number = vim.api.nvim_tabpage_get_number(0)

  local expr = "%" .. number .. "T%X%<" .. number .. " " .. text

  return Component.decorate(expr, l_decor, r_decor)
end

function M.not_current(separator, l_decor, r_decor)
  if #vim.api.nvim_list_tabpages() == 1 then
    return ""
  end

  local list = {}
  local buf = ""
  local sep = separator and separator or "|"
  local ctab = vim.api.nvim_get_current_tabpage()

  for number, handle in pairs(vim.api.nvim_list_tabpages()) do
    if handle ~= ctab then
      buf = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(handle))
      buf = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
      list[#list+1] = "%" .. number .. "T%X" .. number .. " " .. buf
    end
  end

  return Component.decorate(table.concat(list, sep), l_decor, r_decor)
end

return M
