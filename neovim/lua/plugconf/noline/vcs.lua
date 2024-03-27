local M = {}

local Component = require("noline.utility.component")

function M.get(source, symbol)
  local status = ""

  if source == "coc" and vim.g.coc_git_status then
    status = vim.g.coc_git_status
    return Component.decorate(symbol .. status, " ")
  elseif source == "gitsigns" and vim.b.gitsigns_status_dict then
    status = vim.b.gitsigns_status_dict.head
    if #vim.b.gitsigns_status > 0 then
      status = status .. "[" .. vim.b.gitsigns_status .. "]"
    end
    return Component.decorate(symbol .. status, " ")
  end

  return ""
end

return M
