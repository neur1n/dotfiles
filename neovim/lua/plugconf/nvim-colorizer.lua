local M = {}

function M.setup()
  require("colorizer").setup({
    user_default_options = {
      names = false
    }
  })
end

return M
