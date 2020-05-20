scriptencoding utf-8

"*********************************************************** mileszs/ack.vim{{{
if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif
nnoremap <Leader>ag :Ack!<Space>
"}}}
