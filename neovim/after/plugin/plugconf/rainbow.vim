scriptencoding utf-8

"******************************************************* luochen1990/rainbow{{{
if g:loaded_neucs
  let s:plt = neucs#GetPalette()
  let g:rainbow_conf = {
        \ 'ctermfgs': [s:plt.red.c, s:plt.orange.c, s:plt.green.c, s:plt.blue.c],
        \ 'guifgs': [s:plt.red.g, s:plt.orange.g, s:plt.green.g, s:plt.blue.g]
        \ }
endif
"}}}
