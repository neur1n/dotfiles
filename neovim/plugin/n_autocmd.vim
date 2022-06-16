scriptencoding utf-8

if exists('g:loaded_n_autocmd')
  finish
endif

let g:loaded_n_autocmd = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

augroup n_autocmd
  autocmd!
"************************************************************ auto cd to pwd{{{
  autocmd BufEnter * silent! lcd %:p:h
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \| execute "normal! g'\"" | endif
"}}}
"***************************************************************** scrolloff{{{
  autocmd WinEnter,VimResized * execute "setlocal scrolloff=".winheight(win_getid())/3
"}}}
"****************************************************************** skeleton{{{
  autocmd BufNewFile CMakeLists.txt silent! execute 'keepalt read $VIMCONF/template/skeleton.cmake | 1delete | normal gg'
  autocmd BufNewFile * silent! execute 'keepalt read $VIMCONF/template/skeleton.'.expand('<afile>:e') | 1delete | normal gg'
"}}}
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
