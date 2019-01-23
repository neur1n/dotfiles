scriptencoding utf-8

"******************************************************* luochen1990/rainbow{{{
nnoremap <leader>rb :RainbowToggle<CR>
let g:rainbow_active = 1

try
  let s:plt = neutil#palette#Palette()
catch /^Vim\%((\a\+)\)\=:E/
  finish
endtry

let g:rainbow_conf = {
      \ 'ctermfgs': [s:plt.red.c, s:plt.orange.c, s:plt.green.c, s:plt.blue.c],
      \ 'guifgs': [s:plt.red.g, s:plt.orange.g, s:plt.green.g, s:plt.blue.g]
      \ }
"}}}
