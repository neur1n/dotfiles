scriptencoding utf-8

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
