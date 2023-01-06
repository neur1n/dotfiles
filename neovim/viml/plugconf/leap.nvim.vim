scriptencoding utf-8

lua << EOF
vim.keymap.set({'n', 'o', 'x'}, 't', '<Plug>(leap-forward-to)')
vim.keymap.set({'n', 'o', 'x'}, 'T', '<Plug>(leap-backward-to)')
EOF
