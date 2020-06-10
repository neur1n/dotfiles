scriptencoding utf-8

"*********************************************************** mileszs/ack.vim{{{
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
elseif executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif
nnoremap <Leader>ak :Ack!<Space>
"}}}
