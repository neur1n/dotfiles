scriptencoding utf-8

lua << EOF
require("flash").setup({
  search = {multi_window = false},
  modes = {
    search = {enabled = false},
    char = {jump_labels = true},
  },
})

vim.keymap.set({"n", "x", "o"}, "t", "<Cmd>lua require('plugconf.flash').HopWord(true)<CR>")
vim.keymap.set({"n", "x", "o"}, "T", "<Cmd>lua require('plugconf.flash').HopWord(false)<CR>")
EOF
