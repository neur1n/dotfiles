scriptencoding utf-8

lua << EOF
vim.keymap.set({"n", "o", "x"}, "t", "<Plug>(leap-forward-to)")
vim.keymap.set({"n", "o", "x"}, "T", "<Plug>(leap-backward-to)")

require("leap").add_repeat_mappings("<End>", "<Home>", {
  relative_directions = true,
  modes = {"n", "x", "o"},
})
EOF
