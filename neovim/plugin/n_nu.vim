scriptencoding utf-8

if exists('g:loaded_n_nu')
  finish
endif

let g:loaded_n_nu = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

augroup nu
  autocmd!
  autocmd FileType nu lua require'nu'.setup({complete_cmd_names = false})
augroup end

let &cpoptions = s:save_cpo
unlet s:save_cpo
