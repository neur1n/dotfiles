if !exists('g:lightline')
  let g:lightline = {}
endif

let g:lightline = {
      \ 'active': {
      \     'left': [['mode', 'paste', 'spell'],
      \              ['gitbranch'],
      \              ['filename'],
      \              ['modified', 'readonly']],
      \     'right': [['neomake_count'],
      \               ['lineinfo'],
      \               ['fileformat', 'fileencoding'],
      \               ['tagbar']],
      \ },
      \ 'colorscheme': 'solarized_flood',
      \ 'component': {
      \     'lineinfo': '%4l/%L:%-3v',
      \     'readonly': '%{&readonly ? "":""}',
      \     'spell': '%{&spell ? "S":""}',
      \ },
      \ 'component_function': {
      \     'gitbranch': 'gitbranch#name',
      \     'tagbar': 'lightline_tagbar#component',
      \     'neomake_count': 'neomake#statusline#LocListCounts',
      \ },
      \ 'component_type': {
      \     'neomake_count': 'error',
      \ },
      \ 'separater': {
      \     'left': '', 'right': ''
      \ },
      \ 'subseparater': {
      \     'left': '|', 'right': '|',
      \ },
      \ }

let g:lightline#bufferline#show_number = 1
let g:lightline#trailing_whitespace#indicator = '☰'
let g:lightline_tagbar#format = '%s'
let g:lightline_tagbar#flags = '%f'

let g:lightline.mode_map = {
      \ 'n': 'N',
      \ 'i': 'I',
      \ 'r': 'R',
      \ 'R': 'R',
      \ 'v': 'V',
      \ 'V': 'V',
      \ "": 'V',
      \ 'c': 'C',
      \ 's': 'S',
      \ 'S': 'S',
      \ "": 'S',
      \ 't': 'TERMINAL',
      \ }
