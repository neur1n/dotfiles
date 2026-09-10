local M = {}

function M.setup()
  require("flash").setup({
    highlight = {
      backdrop = false,
    },
    modes = {
      char = {
        enabled = false,
      },
      search = {
        enabled = true,
      },
    },
  })
end

return M
