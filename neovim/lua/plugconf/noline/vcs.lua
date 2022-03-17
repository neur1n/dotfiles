local api = vim.api

local M = {}

local Component = require("noline.utility.component")

local shrink_threshold = 80

function M.get(source, symbol)
  if api.nvim_win_get_width(0) < shrink_threshold then
    return ""
  end

  local expr = ""
  local status = vim.g.coc_git_status

  if source == "coc" and status ~= nil and status ~= "" then
    expr = Component.decorate(symbol .. status, " ")
  end

  return expr
end

return M
