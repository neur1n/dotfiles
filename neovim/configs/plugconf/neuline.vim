scriptencoding utf-8

"************************************************************ Neur1n/neuline{{{
let g:neuline = {
      \ 'stl': {
      \   'left': {
      \     'active': ['mode', 'vcs', 'bufinfo', 'modif', 'windowsswap'],
      \     'inactive': ['bufinfo', 'modif', 'windowsswap']
      \   },
      \   'right': {
      \     'active': ['tagbar', 'fileinfo', 'ruler', 'linti', 'linth', 'lintw', 'linte'],
      \     'inactive': ['ruler']
      \   },
      \   'definition': {
      \     'bufinfo': {'tag': 'NSbufinfo', 'def': neuline#part#bufinfo#_(['[', 'Num', ']', 'Name'])},
      \     'vcs': {'tag': 'NSvcs', 'def': ['NeulineVCS()']},
      \     'windowsswap': {'tag': 'NSwindowswap', 'def': ['NeulineWindowSwap()']},
      \     'tagbar': {'tag': 'NStag', 'def': ['NeulineTag()']},
      \     'linti': {'tag': 'NSlintI', 'def': ['NeulineLint("information", "")']},
      \     'linth': {'tag': 'NSlintH', 'def': ['NeulineLint("hint", "")']},
      \     'lintw': {'tag': 'NSlintW', 'def': ['NeulineLint("warning", "")']},
      \     'linte': {'tag': 'NSlintE', 'def': ['NeulineLint("error", "✘")']},
      \   }
      \ },
      \ 'tal': {
      \   'left': ['logo', 'bufinfo', 'asyncrun'],
      \   'right': ['neuims', 'ctab', 'nctab', 'button'],
      \   'definition': {
      \     'asyncrun': {'tag': 'NTasyncrun', 'def': ['NeulineAsyncRun()']},
      \     'neuims': {'tag': 'NTneuims', 'def': ['NeulineNeuIMS()']},
      \     'button': {'tag': 'NTbutton', 'def': ['%999X', 'NeulineCloseButton()']},
      \   },
      \ },
      \ }

try
  let s:plt = neutil#palette#Palette()
catch /^Vim\%((\a\+)\)\=:E/
  finish
endtry

call neutil#palette#Highlight('NSbufinfoN', s:plt.bgh, s:plt.cyan)
call neutil#palette#Highlight('NSbufinfoI', s:plt.bgh, s:plt.blue)
call neutil#palette#Highlight('NSbufinfoV', s:plt.bgh, s:plt.orange)
call neutil#palette#Highlight('NSbufinfoR', s:plt.bgh, s:plt.blue)
call neutil#palette#Highlight('NSbufinfoC', s:plt.bgh, s:plt.cyan)

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

call neutil#palette#Highlight('NSvcs', s:plt.fgm, s:plt.graym)
"}}}

"*************************************************************** windowsswap{{{
function! NeulineWindowSwap() abort
  if exists('g:loaded_windowswap')
    return WindowSwap#IsCurrentWindowMarked() ? '' : ''
  else
    return ''
  endif
endfunction

call neutil#palette#Highlight('NSwindowswap', s:plt.orange, s:plt.bgh)
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
call neutil#palette#Highlight('NSlintI', s:plt.bgh, s:plt.green)
call neutil#palette#Highlight('NSlintH', s:plt.bgh, s:plt.blue)
call neutil#palette#Highlight('NSlintW', s:plt.bgh, s:plt.orange)
call neutil#palette#Highlight('NSlintE', s:plt.bgh, s:plt.red)

function! NeulineLint(type, symbol) abort
  let l:lint_info = get(b:, 'coc_diagnostic_info', {})

  if !empty(l:lint_info)
    let l:count = get(l:lint_info, a:type, 0)

    if l:count > 0
      return printf(' %s %d ', a:symbol, l:count)
    endif
  endif

  return ''
endfunction
"}}}

"****************************************************************** asyncrun{{{
call neutil#palette#Highlight('NTasyncrun', s:plt.grays, s:plt.grays)
call neutil#palette#Highlight('NTasyncrunR', s:plt.blue, s:plt.grays)
call neutil#palette#Highlight('NTasyncrunI', s:plt.yellow, s:plt.grays)
call neutil#palette#Highlight('NTasyncrunF', s:plt.green, s:plt.grays)
call neutil#palette#Highlight('NTasyncrunE', s:plt.red, s:plt.grays)

let s:run_once = v:true
let s:interrupted = v:false

function! NeulineAsyncRun() abort
  if exists(':AsyncRun')
    let l:status = get(g:, 'asyncrun_status', '')
    if l:status ==# 'running'
      if s:run_once
        let s:run_once = v:false
        highlight clear NTasyncRun
      endif

      let s:interrupted = v:false

      highlight link NTasyncRun NTasyncrunR
      return ''
    elseif l:status ==# 'success'
      if s:run_once
        let s:run_once = v:false
        highlight clear NTasyncRun
      endif

      if s:interrupted
        let s:interrupted = v:false
        highlight link NTasyncRun NTasyncRunI
        return ''
      else
        let s:interrupted = v:false
        highlight link NTasyncRun NTasyncRunF
        return '✓'
      endif
    elseif l:status ==# 'failure'
      if s:run_once
        let s:run_once = v:false
        highlight clear NTasyncRun
      endif

      if s:interrupted
        highlight link NTasyncRun NTasyncRunI
        return ''
      else
        let s:interrupted = v:false
        highlight link NTasyncRun NTasyncRunE
        return '✘'
      endif
    endif
  endif

  return ''
endfunction

augroup neuline_custom
  autocmd!
  autocmd User AsyncRunStart call neustl#Update() | call neutal#Update()
  autocmd User AsyncRunStop call neustl#Update() | call neutal#Update()
  autocmd User AsyncRunInterrupt let s:interrupted = v:true
augroup END
"}}}

"******************************************************************** neuims{{{
call neutil#palette#Highlight('NTneuims', s:plt.yellow, s:plt.grays)

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

"************************************************************** close button{{{
call neutil#palette#Highlight('NTbutton', s:plt.fgs, s:plt.red, 'bold')

function! NeulineCloseButton() abort
  if tabpagenr('$') == 1
    return ''
  else
    return '  '
  endif
endfunction
"}}}
"}}}
