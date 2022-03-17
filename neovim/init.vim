scriptencoding utf-8

set nocompatible
set fileformat=unix    " The following two make Vim create unix file by default
set fileformats=unix,dos

if has('win32')
  let $VIMCONFIG=$HOME.'/AppData/Local/nvim'
  let g:python3_host_prog='python'
else
  let $VIMCONFIG=$HOME.'/.config/nvim'
  if filereadable($HOME.'/miniconda3/bin/python3')
    let $PATH=$HOME.'/miniconda3/bin/:'.$PATH
    let g:python3_host_prog=$HOME.'/miniconda3/bin/python3'
  else
    let g:python3_host_prog='/usr/bin/python3'
  endif
endif

"********************************************************* Vim Specific Part{{{
if !has('nvim')
  let g:python_host_skip_check=1
  let g:loaded_python3_provider=1

  if has('gui_running')
    nnoremap <C-F9> :if &go=~#'L'<Bar>set go-=L<Bar>else<Bar>set go+=L<Bar>endif<CR>
    nnoremap <C-F10> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>
    set guioptions-=T
    set guioptions-=m
    set guioptions-=L
    set guioptions-=r
    set guioptions-=e
  endif

  set guifont=Input\ NF:h10
  set lines=30 columns=120
endif
"}}}

"***************************************** The Common Part of Vim and Neovim{{{
source $VIMCONFIG/configs/common.vim
"}}}

"*********************************************************** Moduled Configs{{{
source $VIMCONFIG/configs/autocmd.vim
source $VIMCONFIG/configs/keymap.vim
source $VIMCONFIG/configs/pluglist.vim
source $VIMCONFIG/configs/plugconf.vim
"}}}
