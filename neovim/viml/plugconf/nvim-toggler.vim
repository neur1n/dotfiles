scriptencoding utf-8

lua << EOF
require("nvim-toggler").setup({
  remove_default_keybinds = true,
  inverses = {
    ["True"] = "False"
  },
})

vim.keymap.set({"n", "v"}, "<Leader>tg", require("nvim-toggler").toggle)
EOF