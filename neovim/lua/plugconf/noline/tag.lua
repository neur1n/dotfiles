local M = {}

local Component = require("noline.utility.component")

local function treesitter_current_function()
  local node = vim.treesitter.get_node()
  if not node then
    return ""
  end

  local expr = node
  while expr do
    if expr:type() == "function_declaration" or expr:type() == "function_definition" then
      break
    end

    expr = expr:parent()
  end

  if not expr then
    return ""
  end

  expr = vim.treesitter.get_node_text(expr:child(1), 0)

  return string.gsub(expr, "%b()", "")
end

function M.get(symbol, l_decor, r_decor)
  local expr = ""

  if vim.b.coc_current_function ~= nil then
    expr = vim.b.coc_current_function
  else
    expr = treesitter_current_function()
  end

  if expr ~= "" and type(symbol) == "string" then
    expr = Component.decorate(symbol .. expr, l_decor, r_decor)
  end

  return expr
end

return M
