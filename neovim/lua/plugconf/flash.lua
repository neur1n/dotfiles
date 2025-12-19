local M = {}

function M.keymap()
  return {
    {"r", "<Cmd>lua require('flash').remote()<CR>", mode = "o", {noremap = true, silent = true}},
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
        label = {
          exclude = "cdy"
        },
      },
    },
  })
end

return M
