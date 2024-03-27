local M = {}

function M.setup()
  require("zen-mode").setup({
    enabled = false,
    plugins = {
      options = {
        laststatus = 3,
        showcmd = true,
      }
    },
  })
end

return M
