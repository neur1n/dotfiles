scriptencoding utf-8

"************************************************************ Neur1n/neuline{{{
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
      \   'definition': {
      \     'vcs': {'tag': 'NSvcs', 'def': ['NeulineVCS()']},
      \     'windowsswap': {'tag': 'NSwindowswap', 'def': ['NeulineWindowSwap()']},
      \     'tagbar': {'tag': 'NStag', 'def': ['NeulineTag()']},
      \     'lint': {'tag': 'NSlint', 'def': ['NeulineLint()']},
      \   }
      \ },
      \ 'tal': {
      \   'left': ['logo', 'bufinfo', 'asyncrun'],
      \   'right': ['neuims', 'ctab', 'nctab', 'button'],
      \   'definition': {
      \     'asyncrun': {'tag': 'NTasyncrun', 'def': ['NeulineAsyncRun()']},
      \     'neuims': {'tag': 'NTneuims', 'def': ['NeulineNeuIMS()']},
      \   }
      \ },
      \ }

try
  let s:plt = neutil#palette#Palette()
catch /^Vim\%((\a\+)\)\=:E/
  finish
endtry

"*********************************************************************** vcs{{{
function! NeulineVCS() abort
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

call neutil#palette#Highlight('NSvcs', s:plt.fgm, s:plt.graym, 'bold')
"}}}

"*************************************************************** windowsswap{{{
function! NeulineWindowSwap() abort
  if exists('g:loaded_windowswap')
    return WindowSwap#IsCurrentWindowMarked() ? '' : ''
  else
    return ''
  endif
endfunction

call neutil#palette#Highlight('NSwindowswap', s:plt.orange, s:plt.bgh, 'bold')
"}}}

"*********************************************************************** tag{{{
function! NeulineTag() abort
  if exists(':Tagbar')
    let l:tag = tagbar#currenttag('%s', '', '%f')
    return l:tag ==# '' ? '' : l:tag.' '
  elseif exists(':Vista')
    let l:tag = get(b:, 'vista_nearest_method_or_function', '')
    return l:tag ==# '' ? '' : l:tag.' '
  else
    return ''
  endif
endfunction

call neutil#palette#Highlight('NStag', s:plt.fgh, s:plt.bgh, 'italic')
"}}}

"********************************************************************** lint{{{
call neutil#palette#Highlight('NSlintI', s:plt.bgh, s:plt.blue, 'bold')
call neutil#palette#Highlight('NSlintH', s:plt.bgh, s:plt.green, 'bold')
call neutil#palette#Highlight('NSlintW', s:plt.bgh, s:plt.orange, 'bold')
call neutil#palette#Highlight('NSlintE', s:plt.bgh, s:plt.red, 'bold')

function! NeulineLint() abort
  if !empty(get(b:, 'coc_diagnostic_info', {}))
    return s:GatherInfo(get(b:, 'coc_diagnostic_info', {}),
          \ {'i': 'information', 'h': 'hint', 'w': 'warning', 'e': 'error'},
          \ '[CoC]')
  elseif !empty(neomake#statusline#LoclistCounts())
    return s:GatherInfo(neomake#statusline#LoclistCounts(),
          \ {'i': 'I', 'h': 'H', 'w': 'W', 'e': 'E'}, '[Neomake]')
  else
    return ''
  endif
endfunction

function! s:GatherInfo(info, keys, tag) abort
  let l:msg = []

  if get(a:info, a:keys.e, 0)
    call add(l:msg, '✘'.a:info[a:keys.e])
    highlight link NSlint NSlintE
  endif
  if get(a:info, a:keys.w, 0)
    call add(l:msg, ''.a:info[a:keys.w])
    highlight link NSlint NSlintW
  endif
  if get(a:info, a:keys.h, 0)
    call add(l:msg, ''.a:info[a:keys.h])
    highlight link NSlint NSlintH
  endif
  if get(a:info, a:keys.i, 0)
    call add(l:msg, ''.a:info[a:keys.i])
    highlight link NSlint NSlintI
  endif

  return empty(l:msg) ? '' : ' '.a:tag.join(l:msg, ' ').' '
endfunction
"}}}

"****************************************************************** asyncrun{{{
call neutil#palette#Highlight('NTasyncrunE', s:plt.red, s:plt.grays, 'bold')
call neutil#palette#Highlight('NTasyncrunR', s:plt.blue, s:plt.grays, 'bold')
call neutil#palette#Highlight('NTasyncrunF', s:plt.green, s:plt.grays, 'bold')

function! NeulineAsyncRun() abort
  if exists(':AsyncRun')
    let l:status = get(g:, 'asyncrun_status', '')
    if l:status ==# ''
      highlight link NTasyncrun NTasyncrunF
      return ''
    elseif l:status ==# 'failure'
      highlight link NTasyncrun NTasyncrunE
      return '[AsyncRun] ✘'
    elseif l:status ==# 'running'
      highlight link NTasyncrun NTasyncrunR
      return '[AsyncRun] '
    elseif l:status ==# 'success'
      highlight link NTasyncrun NTasyncrunF
      return '[AsyncRun] ✓'
    endif
  endif

  return ''
endfunction

augroup neuline_custom
  autocmd!
  autocmd User AsyncRunStart call neustl#Update() | call neuline#stl#highlight#Link()
  autocmd User AsyncRunStop call neustl#Update() | call neuline#stl#highlight#Link()
  autocmd User AsyncRunStart call neutal#Update() | call neuline#tal#highlight#Link()
  autocmd User AsyncRunStop call neutal#Update() | call neuline#tal#highlight#Link()
augroup end
"}}}
"******************************************************************** neuims{{{
call neutil#palette#Highlight('NTneuims', s:plt.yellow, s:plt.grays, 'bold')

function! NeulineNeuIMS() abort
  if winwidth(0) >= 60
    if exists('g:neuims')
      if g:neuims.status == 1
        return ' '.g:neuims.im.' '
      else
        return ''
      endif
    else
      return ''
    endif
  else
    return ''
  endif
endfunction
"}}}
"}}}
