local M = {}

function M.setup()
  require("ibl").setup({
    enabled = false,
    indent = {highlight = "Function"},
    whitespace = {highlight = "Normal"},
  })
end

return M
