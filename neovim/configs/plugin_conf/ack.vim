scriptencoding utf-8

"************************************************************* {mileszs/ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
nnoremap <Leader>ag :Ack!<Space>
" }
