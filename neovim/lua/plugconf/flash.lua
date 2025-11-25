local M = {}

function M.setup()
  require("flash").setup({
    modes = {
      char = {
        highlight = {
          backdrop = false,
        },
        jump_labels = true,
      },
      search = {
        enabled = true,
      }
    },
  })
end

return M
