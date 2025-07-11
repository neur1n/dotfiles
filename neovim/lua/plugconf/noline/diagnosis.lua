local M = {}

local Component = require("noline.component")

function M.info(source, type, symbol, l_decor, r_decor)
  local count = 0

  if source == "coc" and vim.b.coc_diagnostic_info then
    count = vim.b.coc_diagnostic_info[type]
  elseif source == "lsp" then
    count = #vim.diagnostic.get(0, {severity = type})
  end

  if count > 0 then
    return Component.decorate(symbol .. count, l_decor, r_decor)
  end

  return ""
end

return M
