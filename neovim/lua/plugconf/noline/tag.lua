local M = {}

local Component = require("noline.utility.component")

function M.get(symbol, l_decor, r_decor)
  local expr = ""

  if vim.b.coc_current_function ~= nil then
    expr = vim.b.coc_current_function
  end

  if expr ~= "" and type(symbol) == "string" then
    expr = Component.decorate(symbol .. " " .. expr, l_decor, r_decor)
  end

  return expr
end

return M
