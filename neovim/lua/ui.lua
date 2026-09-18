local M = {}

function M.setup()
  require("vim._core.ui2").enable()

  vim.cmd("colorscheme neudom")
end

return M
