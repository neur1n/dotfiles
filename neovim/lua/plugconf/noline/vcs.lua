local M = {}

local Component = require("noline.utility.component")

function M.get(source, symbol)
  local expr = ""
  local status = vim.g.coc_git_status

  if source == "coc" and status ~= nil and status ~= "" then
    expr = Component.decorate(symbol .. status, " ")
  end

  return expr
end

return M
