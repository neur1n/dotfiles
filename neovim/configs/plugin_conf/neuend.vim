scriptencoding utf-8
let g:neu = {
      \ 'stl': {
      \   'faster': 1,
      \   'left': {'active': ['mode', 'vcs', 'bufinfo', 'modif', 'windowswap'],
      \            'inactive': ['bufinfo', 'modif', 'windowswap']},
      \   'right': {'active': ['tagbar', 'fileinfo', 'ruler', 'linti', 'linth', 'lintw', 'linte'],
      \             'inactive': ['ruler']},
      \ },
      \ 'tal': {
      \   'faster': 0,
      \   'left': ['logo', 'bufinfo', 'neurun']
      \ }
      \ }

" if !exists('g:neu.stl.section')
"   let g:neu.stl.section = {}
" endif
" let g:neuline.section.bufinfo = ['NSbufinfo', preset#bufinfo#Info(['Num', ':', 'Rcwd', '/', 'Name'])]
" let g:neuline.section.ruler = ['NSruler', '%5l--%L:%-2v']
