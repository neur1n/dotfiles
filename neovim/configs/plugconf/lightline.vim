scriptencoding utf-8

"***************************************************** itchyny/lightline.vim{{{
set showtabline=2

let g:lightline = {}

let g:lightline.active = {
      \ 'left': [['mode', 'paste'],
      \          ['vcs'],
      \          ['filename', 'modified']],
      \ 'right': [['lineinfo', 'linti', 'linth', 'lintw', 'linte', 'stllink'],
      \           ['fileinfo']]
      \ }

let g:lightline.inactive = {
      \ 'left': [['filename_ia']],
      \ 'right': [['lineinfo_ia'],
      \           ['percent']]
      \ }

let g:lightline.tabline = {
      \ 'left': [['path']],
      \ 'right': [['ctab', 'nctab', 'close']]
      \ }

let g:lightline.component = {
      \ 'mode': '%#LMode# %{LightlineMode()} ',
      \ 'vcs': '%#LVcs#%{LightlineVCS()}',
      \ 'filename': '%#LBufInfo# [%n]%t ',
      \ 'modified': '%#LModif# %m%{&readonly ? "" : ""}',
      \ 'lineinfo': '%#LLineInfo#%4l/%L:%-3v',
      \ 'linti': '%#LLintI#%{LightlineLintI()}',
      \ 'linth': '%#LLintH#%{LightlineLintH()}',
      \ 'lintw': '%#LLintW#%{LightlineLintW()}',
      \ 'linte': '%#LLintE#%{LightlineLintE()}',
      \ 'stllink': '%{LightlineStatuslineLink()}',
      \ 'fileinfo': '%#LFileInfo# %Y[%{(&fileencoding ? &fileencoding : &encoding).":".(&fileformat)}] ',
      \ 'filename_ia': '%#LBufInfoIA# [%n]%t ',
      \ 'lineinfo_ia': '%#LLineInfoIA#%4l/%L:%-3v',
      \ 'path': '%#LPath#%{getcwd()}',
      \ 'ctab': '%#LCurrentTab#%{LightlineCurrentTabs()}',
      \ 'nctab': '%#LNonCurrentTab#%{LightlineNonCurrentTabs()}',
      \ 'close': '%#LCloseButton#%999X%{LightlineCloseButton()}',
      \ }

let g:lightline.component_type = {
      \ 'mode': 'raw',
      \ 'vcs': 'raw',
      \ 'filename': 'raw',
      \ 'modified': 'raw',
      \ 'lineinfo': 'raw',
      \ 'linti': 'raw',
      \ 'linth': 'raw',
      \ 'lintw': 'raw',
      \ 'linte': 'raw',
      \ 'fileinfo': 'raw',
      \ 'filename_ia': 'raw',
      \ 'lineinfo_ia': 'raw',
      \ }

let g:lightline.separator = {'left': '', 'right': ''}
let g:lightline.subseparator = {'left': '', 'right': ''}

let s:plt = neutil#palette#Palette()

"*************************************************************** Hightlights{{{
let s:color_map = {
      \ 'N': [s:plt.green, s:plt.cyan],
      \ 'I': [s:plt.cyan, s:plt.blue],
      \ 'V': [s:plt.yellow, s:plt.orange],
      \ 'R': [s:plt.purple, s:plt.blue],
      \ 'C': [s:plt.red, s:plt.cyan],
      \ }

let s:link_map = {
      \ 'n':  'N',
      \ 'no': 'N',
      \ 'i':  'I',
      \ 'v':  'V',
      \ 'V':  'V',
      \ '': 'V',
      \ 'R':  'R',
      \ 'r':  'R',
      \ 'c':  'C',
      \ 't':  'C',
      \ }

let s:prev_mode = ''

function! s:HiStatic() abort
  " Inactive mode and file info.
  call neutil#palette#Highlight('LBufInfoIA', s:plt.fgm, s:plt.grays)
  call neutil#palette#Highlight('LModifIA', s:plt.purple, s:plt.grays)
  call neutil#palette#Highlight('LLineInfoIA', s:plt.fgm, s:plt.grays)
  call neutil#palette#Highlight('LFileInfo', s:plt.bgh, s:plt.graym)
endfunction

function! s:HiDynamic(mode) abort
  call neutil#palette#Highlight('LMode'.a:mode, s:plt.bgh, s:color_map[a:mode][0])
  call neutil#palette#Highlight('LBufInfo'.a:mode, s:plt.bgh, s:color_map[a:mode][1])
  call neutil#palette#Highlight('LModif'.a:mode, s:plt.red, s:plt.bgh)
  call neutil#palette#Highlight('LLineInfo'.a:mode, s:plt.bgh, s:color_map[a:mode][0])
endfunction

call s:HiStatic()
call s:HiDynamic('C')
call s:HiDynamic('I')
call s:HiDynamic('N')
call s:HiDynamic('R')
call s:HiDynamic('V')

function! LightlineStatuslineLink() abort
  for w in range(1, winnr('$'))
    if w == winnr()
      " let l:mode = get(s:link_map, a:0 ? a:1 : mode(), 'n')
      let l:mode = get(s:link_map, mode(), 'n')

      if l:mode !=# s:prev_mode
        let s:prev_mode = l:mode
        execute 'highlight link LMode LMode'.l:mode
        execute 'highlight link LBufInfo LBufInfo'.l:mode
        execute 'highlight link LModif LModif'.l:mode
        execute 'highlight link LLineInfo LLineInfo'.l:mode

        "  Override Lightline groups.
        execute 'highlight link LightLineMiddle_active LModif'.l:mode
      endif
    endif
  endfor

  return ''
endfunction

call neutil#palette#Highlight('LVcs', s:plt.fgm, s:plt.graym)

call neutil#palette#Highlight('LLintI', s:plt.bgh, s:plt.blue  )
call neutil#palette#Highlight('LLintH', s:plt.bgh, s:plt.green )
call neutil#palette#Highlight('LLintW', s:plt.bgh, s:plt.orange)
call neutil#palette#Highlight('LLintE', s:plt.bgh, s:plt.red   )

call neutil#palette#Highlight('LPath', s:plt.bgh, s:plt.grays)
call neutil#palette#Highlight('LCloseButton', s:plt.fgs, s:plt.red, 'bold')
call neutil#palette#Highlight('LCurrentTab', s:plt.orange, s:plt.grays, 'bold')
call neutil#palette#Highlight('LNonCurrentTab', s:plt.bgh, s:plt.grays)

let g:lightline['colorscheme'] = 'default'
let s:default_plt = g:lightline#colorscheme#default#palette
let s:default_plt.tabline.left = [[s:plt.bgh.g, s:plt.grays.g, s:plt.bgh.c, s:plt.grays.c]]
let s:default_plt.tabline.middle = [[s:plt.bgh.g, s:plt.grays.g, s:plt.bgh.c, s:plt.grays.c]]
let s:default_plt.tabline.right = [[s:plt.bgh.g, s:plt.grays.g, s:plt.bgh.c, s:plt.grays.c]]
let g:lightline#colorscheme#default#palette = s:default_plt
unlet s:default_plt
"}}}

"************************************************************* LightlineLint{{{
function! LightlineLintI() abort
  let l:lint_info = get(b:, 'coc_diagnostic_info', {})

  if !empty(l:lint_info)
    let l:count = get(l:lint_info, 'information', 0)

    if l:count > 0
      return '  '.l:count.' '
    endif
  endif

  return ''
endfunction

function! LightlineLintH() abort
  let l:lint_info = get(b:, 'coc_diagnostic_info', {})

  if !empty(l:lint_info)
    let l:count = get(l:lint_info, 'hint', 0)

    if l:count > 0
      return '  '.l:count.' '
    endif
  endif

  return ''
endfunction

function! LightlineLintW() abort
  let l:lint_info = get(b:, 'coc_diagnostic_info', {})

  if !empty(l:lint_info)
    let l:count = get(l:lint_info, 'warning', 0)

    if l:count > 0
      return '  '.l:count.' '
    endif
  endif

  return ''
endfunction

function! LightlineLintE() abort
  let l:lint_info = get(b:, 'coc_diagnostic_info', {})

  if !empty(l:lint_info)
    let l:count = get(l:lint_info, 'error', 0)

    if l:count > 0
      return ' ✘  '.l:count.' '
    endif
  endif

  return ''
endfunction
"}}}

"************************************************************* LightlineMode{{{
function! LightlineMode() abort
  let l:mode_map = {
        \ 'n':  'N',
        \ 'no': 'NO',
        \ 'i':  'I',
        \ 'v':  'V',
        \ 'V':  'VL',
        \ '': 'VB',
        \ 'R':  'R',
        \ 'c':  'C',
        \ 'r':  'PROMPT',
        \ 't':  'TERMINAL',
        \ 's':  'S',
        \ 'S':  'S',
        \ '': 'S',
        \ '__': '-',
        \ '?':  'UNKNOWN',
        \ }

  if &filetype ==# 'help'
    let l:mode = 'HELP'
  elseif &filetype ==# 'startify'
    let l:mode = 'STARTIFY'
  elseif &filetype ==# 'vim-plug'
    let l:mode = 'VIM-PLUG'
  else
    let l:mode = get(l:mode_map, mode(), '?')
  endif

  let l:mode .= &paste ? '|PASTE' : ''
  let l:mode .= &spell ? '|SPELL' : ''

  return l:mode
endfunction
"}}}

"************************************************************** LightlineVCS{{{
function! LightlineVCS() abort
  if winwidth(0) >= 60
    if get(g:, 'coc_git_status', '') !=# ''
      return ' '.get(g:, 'coc_git_status', '').' '
    else
      return ''
    endif
  else
    return ''
  endif
endfunction
"}}}

"****************************************************** LightlineCurrentTabs{{{
let s:tabs = {'list': [1], 'str': ''}
let s:prev_tab = 0

function! LightlineCurrentTabs() abort
  if tabpagenr('$') == 1
    return ''
  else
    return tabpagenr()
  endif
endfunction
"}}}

"*************************************************** LightlineNonCurrentTabs{{{
function! LightlineNonCurrentTabs() abort
  let l:diff = tabpagenr('$') - len(s:tabs.list)

  if tabpagenr() == s:prev_tab && l:diff == 0
    return s:tabs.str
  else
    let s:tabs.str = ''
  endif

  if tabpagenr() != s:prev_tab || l:diff
    " Put the previous-current tab number back to list, or say sorting.
    " Didn't use sort() here since the following method seems faster.
    call insert(s:tabs.list, s:tabs.list[0], s:tabs.list[0])
    call remove(s:tabs.list, 0)
    let s:prev_tab = tabpagenr()
  endif

  if l:diff < 0
    call remove(s:tabs.list, l:diff, -1)
  elseif l:diff > 0
    for nr in range(1, l:diff)
      call extend(s:tabs.list, [s:tabs.list[-nr]+nr])
    endfor
  endif

  call insert(s:tabs.list, tabpagenr())
  call remove(s:tabs.list, tabpagenr())

  if len(s:tabs.list) < 2
    return ''
  endif

  for nr in s:tabs.list[1:]  " Only take the non-current part
    let s:tabs.str .= ' '.nr
  endfor

  return s:tabs.str
endfunction

"****************************************************** LightlineCloseButton{{{
function! LightlineCloseButton() abort
  if tabpagenr('$') == 1
    return ''
  else
    return '  '
  endif
endfunction
"}}}
"}}}
