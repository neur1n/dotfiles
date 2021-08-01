scriptencoding utf-8

"****************************************************** liuchengxu/vista.vim{{{
if !executable('ctags')
  let g:vista_default_executive = 'coc'
endif

nnoremap <leader>vi :Vista!!<CR>

let g:vista_echo_cursor = 0
let g:vista_close_on_jump = 1
let g:vista_sidebar_keepalt = 1
let g:vista_sidebar_width = 50

augroup vista
  autocmd!
  autocmd FileType c,cpp let g:vista_default_executive = 'coc'
augroup end
"}}}
