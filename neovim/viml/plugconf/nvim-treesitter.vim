scriptencoding utf-8

lua << EOF
-- require("nvim-treesitter.install").prefer_git = false

require("nvim-treesitter.configs").setup {
  ensure_installed = {"c", "nu", "python"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

vim.api.nvim_set_hl(0, "@text.danger", {link = "Error"})
vim.api.nvim_set_hl(0, "@text.note", {link = "Note"})
vim.api.nvim_set_hl(0, "@text.todo", {link = "Todo"})
vim.api.nvim_set_hl(0, "@text.warning", {link = "Todo"})
EOF
