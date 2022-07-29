scriptencoding utf-8

if exists('g:loaded_n_treesitter')
  finish
endif

let g:loaded_n_treesitter = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

lua << EOF
require("nvim-treesitter.configs").setup {
  ensure_installed = {"c", "python"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    loaded = true
  }
}
EOF

let &cpoptions = s:save_cpo
unlet s:save_cpo
