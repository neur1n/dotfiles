scriptencoding utf-8

lua << EOF
require("ibl").setup{
  enabled = false,
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter = true,
}
EOF
