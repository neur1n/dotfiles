scriptencoding utf-8

set list
set listchars=tab:⇥\ ,trail:·,nbsp:␣,extends:»,precedes:«

lua << EOF
require("indent_blankline").setup{
  enabled = false,
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter = true,
}
EOF
