scriptencoding utf-8

let g:neuline = {
      \ 'stl': {
      \   'left': {
      \     'active': ['mode', 'vcs', 'bufinfo', 'modif', 'windowsswap'],
      \     'inactive': ['bufinfo', 'modif', 'windowsswap']
      \   },
      \   'right': {
      \     'active': ['tagbar', 'fileinfo', 'ruler', 'lint'],
      \     'inactive': ['ruler']
      \   },
      \ 'definition': {
      \   'vcs': {'tag': 'NSvcs', 'def': ['NeulineVCS()']},
      \   'windowsswap': {'tag': 'NSwindowswap', 'def': ['NeulineWindowSwap()']},
      \   'tagbar': {'tag': 'NStagbar', 'def': ['NeulineTagbar()']},
      \   'lint': {'tag': 'NSlint', 'def': ['NeulineLint()']},
      \ }
      \ },
      \ 'tal': {
      \   'left': ['logo', 'bufinfo'],
      \   'right': ['ctab', 'nctab', 'button'],
      \ }
      \ }

try
  let s:plt = neutil#palette#Palette()
catch /^Vim\%((\a\+)\)\=:E/
  finish
endtry

"********************************************************************** vcs {{{
function! NeulineVCS() abort
  if get(g:, 'coc_git_status', '') !=# ''
    return ' '.get(g:, 'coc_git_status', '').' '
  endif
  return ''
endfunction

call neutil#palette#Highlight('NSvcs', s:plt.fgm, s:plt.graym, 'bold')
"}}}

"************************************************************** windowsswap {{{
function! NeulineWindowSwap() abort
  if exists('g:loaded_windowswap')
    return WindowSwap#IsCurrentWindowMarked() ? '' : ''
  else
    return ''
  endif
endfunction

call neutil#palette#Highlight('NSwindowswap', s:plt.orange, s:plt.bgh, 'bold')
"}}}

"******************************************************************* tagbar {{{
function! NeulineTagbar() abort
  if exists(':Tagbar')
    let l:tag = tagbar#currenttag('%s', '', '%f')
    return l:tag ==# '' ? '' : l:tag.' '
  else
    return ''
  endif
endfunction

call neutil#palette#Highlight('NStagbar', s:plt.fgh, s:plt.bgh, 'italic')
"}}}

"********************************************************************* lint {{{
" call neutil#palette#Highlight('NSlint', s:plt.fgh, s:plt.bgh, 'bold')
call neutil#palette#Highlight('NSlintI', s:plt.bgh, s:plt.blue, 'bold')
call neutil#palette#Highlight('NSlintH', s:plt.bgh, s:plt.green, 'bold')
call neutil#palette#Highlight('NSlintW', s:plt.bgh, s:plt.orange, 'bold')
call neutil#palette#Highlight('NSlintE', s:plt.bgh, s:plt.red, 'bold')

function! NeulineLint() abort
  if exists('g:did_coc_loaded')
    let l:info = get(b:, 'coc_diagnostic_info', {})

    if empty(l:info)
      return ''
    endif

    let l:msg = []
    if get(l:info, 'error', 0)
      call add(l:msg, '✘'.l:info['error'])
      highlight link NSlint NSlintE
    endif
    if get(l:info, 'warning', 0)
      call add(l:msg, ''.l:info['warning'])
      highlight link NSlint NSlintW
    endif
    if get(l:info, 'hint', 0)
      call add(l:msg, ''.l:info['hint'])
      highlight link NSlint NSlintH
    endif
    if get(l:info, 'information', 0)
      call add(l:msg, ''.l:info['information'])
      highlight link NSlint NSlintI
    endif

    return empty(l:msg) ? '' : ' '.join(l:msg, ' ').' '
  else
    return ''
  endif
endfunction
"}}}
