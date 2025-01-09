local M = {}

function M.setup()
  require("focus").setup({
    enable = true,
    ui = {
      signcolumn = false,
    }
  })
end

return M
