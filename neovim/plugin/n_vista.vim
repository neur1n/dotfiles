scriptencoding utf-8

if exists('g:loaded_n_vista')
  finish
endif

let g:loaded_n_vista = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

nnoremap <leader>vi :Vista!!<CR>

let g:vista_close_on_jump = 1
let g:vista_default_executive = 'coc'
let g:vista_echo_cursor = 0
let g:vista_sidebar_keepalt = 1
let g:vista_sidebar_width = 50
let g:vista#renderer#enable_icon=1

augroup vista
  autocmd!
  autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
augroup end

let &cpoptions = s:save_cpo
unlet s:save_cpo
