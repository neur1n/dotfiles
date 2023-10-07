scriptencoding utf-8

lua << EOF
require("zen-mode").setup{
  plugins = {
    options = {
      laststatus = 3,
      showcmd = true,
    },
  },
  enabled = false,
}
EOF

nnoremap <Leader>zm <Cmd>ZenMode<CR>
