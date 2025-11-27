local M = {}

function M.keymap()
  return {
    {"s", "<Cmd>lua require('flash').jump()<CR>", mode = {"n", "o", "x"}, {noremap = true, silent = true}},
  }
end

function M.setup()
  require("flash").setup({
    highlight = {
      backdrop = false,
    },
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
