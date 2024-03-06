scriptencoding utf-8

augroup n_autocmd
  autocmd!
"************************************************************ auto cd to pwd{{{
  autocmd BufEnter * silent! lcd %:p:h
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \| execute "normal! g'\"" | endif
"}}}
"*************************************** relative line number in visual mode{{{
  autocmd ModeChanged [vV\x16]*:* let &l:relativenumber = mode() =~# '^[vV\x16]'
  autocmd ModeChanged *:[vV\x16]* let &l:relativenumber = mode() =~# '^[vV\x16]'
  autocmd WinEnter,WinLeave * let &l:relativenumber = mode() =~# '^[vV\x16]'
"}}}
"***************************************************************** scrolloff{{{
  autocmd BufWinEnter,VimResized,WinEnter * execute 'setlocal scrolloff='.winheight(win_getid())/3
  autocmd BufWinEnter,VimResized,WinEnter * execute 'setlocal sidescrolloff='.winwidth(win_getid())/3
"}}}
augroup END
