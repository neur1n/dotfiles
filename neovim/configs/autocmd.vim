scriptencoding utf-8

"****************************************************************** AutoCMDs{{{
augroup auto_cd
  autocmd!
  autocmd BufEnter * silent! lcd %:p:h                         " auto cd to pwd
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \| execute "normal! g'\"" | endif
augroup END

augroup scroll_off
  autocmd!
  autocmd WinEnter,VimResized * execute "setlocal scrolloff=".winheight(win_getid())/3
augroup END

augroup templates
  autocmd!
  autocmd BufNewFile * silent! execute 'keepalt 0r $VIMCONFIG/templates/skeleton.'.expand('<afile>:e')
augroup END
"}}}
