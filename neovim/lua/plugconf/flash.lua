local M = {}

function M.keymap()
  return {
    {"s", "<Cmd>lua require('flash').jump()<CR>", mode = "n", {noremap = true, silent = true}},
  }
end

function M.setup()
  require("flash").setup({
    modes = {
      char = {
        highlight = {
          backdrop = false,
        },
        jump_labels = true,
      },
    },
  })
end

return M
