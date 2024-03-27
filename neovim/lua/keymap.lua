local M = {}

function M.setup()
  vim.keymap.set("n", "Q", "<NOP>", {noremap = true})

  vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {noremap = true})

  vim.keymap.set("n", "G", "Gzz", {noremap = true})
  vim.keymap.set({"n", "v"}, "j", "gj", {noremap = true})
  vim.keymap.set({"n", "v"}, "k", "gk", {noremap = true})

  vim.cmd([[vnoremap // y/\V<C-R>=escape(@", '\/')<CR><CR>]])
end

return M
