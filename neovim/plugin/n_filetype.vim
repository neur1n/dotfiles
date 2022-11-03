scriptencoding utf-8

if exists('g:loaded_n_filetype')
  finish
endif

let g:loaded_n_filetype = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

lua << EOF
vim.filetype.add({
  extension = {
    cmd = "dosbatch",
  },
})
EOF

let &cpoptions = s:save_cpo
unlet s:save_cpo
