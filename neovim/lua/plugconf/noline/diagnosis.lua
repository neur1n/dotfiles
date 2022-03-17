local M = {}

local Component = require("noline.utility.component")

function M.info(source, type, symbol, l_decor, r_decor)
  if source == "coc" and vim.b.coc_diagnostic_info ~= nil then
    local count = vim.b.coc_diagnostic_info[type]

    if count > 0 then
      return Component.decorate(symbol .. " " .. count, l_decor, r_decor)
    end
  end

  return ""
end

return M
