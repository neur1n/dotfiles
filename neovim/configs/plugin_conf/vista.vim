scriptencoding utf-8

"****************************************************** liuchengxu/vista.vim{{{
if !executable('ctags')
  let g:vista_default_executive = 'coc'
endif

nnoremap <leader>tv :Vista!!<CR>

let g:vista_echo_cursor = 0
let g:vista_close_on_jump = 1
"}}}