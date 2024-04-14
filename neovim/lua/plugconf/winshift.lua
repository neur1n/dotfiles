local M = {}

function M.keymap()
  return {
    {"<Leader>ws", "<Cmd>WinShift swap<CR>", mode = {"n"}, {noremap = true}},
  }
end

function M.setup()
  require("winshift").setup({
    highlight_moving_win = true,
    focused_hl_group = "Visual",
    keymaps = {
      disable_defaults = true,
    },
  })
end

return M
