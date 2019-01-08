scriptencoding utf-8

let s:save_cpo = &cpoptions
set cpoptions&vim

let s:autosave = 2  " 0: do not; 1: save current buffer; 2: save all
let s:cb = {}
let s:curjob = 0
let s:interrupt = 0
let s:prefix = '[neurun] '
let s:qfopened = 0
let s:startup = 1
let s:start_stamp = 0

"***************************************************************** {{{ Messages
function! s:Highlight() abort
  let l:palette = palette#Palette()
  call palette#Highlight('NeuInfo', l:palette.blue, 'bg', 'bold')
  call palette#Highlight('NeuHint', l:palette.green, 'bg', 'bold')
  call palette#Highlight('NeuWarning', l:palette.yellow, 'bg', 'bold')
  call palette#Highlight('NeuError', l:palette.red, 'bg', 'bold')
endfunction

function! s:EchoMsg(type, msg) abort
  if a:type ==# 'i'
    echohl NeuInfo
  elseif a:type ==# 'h'
    echohl NeuHint
  elseif a:type ==# 'w'
    echohl NeuWarning
  elseif a:type ==# 'e'
    echohl NeuError
  else
    echohl WarningMsg
  endif
  echom s:prefix.a:msg
  echohl NONE
endfunction

function! s:QFMsg(msg) abort
  call setqflist([{'text': s:prefix.a:msg}], 'a')
endfunction

function! s:JoinData(data) abort
  let l:joined = ''
  for i in a:data
    let l:joined .= i
  endfor
  return l:joined
endfunction
" }}}

"************************************************************ {{{ Miscellaneous
function! s:AutoScroll() abort
  if &buftype ==# 'quickfix' && line('.') == line('$')
    silent execute 'normal! Gzz'
  endif
endfunction

function! s:ShowElapsedTime() abort
  let l:cnt = reltimefloat(reltime(s:start_stamp))
  call s:QFMsg(printf('%f seconds elapsed.', l:cnt))
endfunction

function! s:DoAutoCmd(cmd) abort
  silent execute 'doautocmd User Neurun'.a:cmd
endfunction
" }}}

"************************************************************** {{{ Job Control
function! s:JobStart(cmd) abort
  if has('nvim')
    let s:curjob = jobstart(a:cmd, s:cb)
  else
    let s:curjob = job_start(a:cmd, s:cb)
  endif

  if s:curjob > 0
    call s:EchoMsg('i', 'Running ')
    let s:start_stamp = reltime()
    call s:QFMsg(join(a:cmd))
    call s:DoAutoCmd('Start')
  elseif s:curjob == 0
    call s:EchoMsg('e', 'Failed ✘')
    call s:QFMsg(join(a:cmd).': Invalid arguments or job table is full.')
    call s:DoAutoCmd('Fail')
  elseif s:curjob == -1
    call s:EchoMsg('e', 'Failed ✘')
    call s:QFMsg(join(a:cmd).': Command is not executable.')
    call s:DoAutoCmd('Fail')
  else
    call s:EchoMsg('e', 'Failed ✘')
    call s:QFMsg(join(a:cmd).': Unknown failure.')
    call s:DoAutoCmd('Fail')
  endif
endfunction

function! s:JobStop() abort
  if exists('s:curjob')
    if has('nvim')
      if s:curjob > 0
        call jobstop(s:curjob)
      endif
    else
      if job_status(s:curjob) ==# 'run'
        call job_stop(s:curjob)
      endif
    endif

    " call s:ShowElapsedTime()
    call s:EchoMsg('w', 'Stopped ')

    let s:interrupt = 1
    unlet s:curjob
    call s:DoAutoCmd('Stop')
  endif
endfunction

function! s:OutCB(jobid, data, event) abort
  let l:joined = s:JoinData(a:data)
  if l:joined !=# ''
    call s:QFMsg(l:joined)
  endif
endfunction

function! s:ErrCB(jobid, data, event) abort
  if !s:interrupt
    if v:shell_error == 0
      call s:EchoMsg('h', 'Finished ✓')
    else
      call s:EchoMsg('e', 'Error ✘')
    endif
  endif
  let s:interrupt = 0

  let l:joined = s:JoinData(a:data)
  if l:joined !=# ''
    let l:msg = printf('Shell returns %s. (Extra: %s)', v:shell_error, l:joined)
  else
    let l:msg = printf('Shell returns %s.', v:shell_error)
  endif

  call s:QFMsg(l:msg)
  call s:ShowElapsedTime()
endfunction

function! s:ExitCB(jobid, data, event) abort
  call s:QFMsg('Exited.')
endfunction
" }}}

"****************************************************************** {{{ Runnees
function! s:RunMarkdown() abort
  if has('unix')
    let l:browser = get(g:, 'runner.markdown.browser.unix', 'vivaldi')
  elseif has('win32')
    let l:browser = get(g:, 'runner.markdown.browser.win', 'vivaldi')
  endif

  return [l:browser, bufname('%')]
endfunction

function! s:RunPython() abort
  if filereadable('MAINFILE')  " Workspace
    let l:main = readfile('MAINFILE')[0]
  elseif get(g:, 'runner.python.main', '') !=# ''  " Global
    let l:main = g:runner.python.main
  else  " Current buffer
    let l:main = bufname('%')
  endif

  let l:python = get(g:, 'runner.python.provider', 'python3')

  return [l:python, '-u', l:main]
endfunction
" }}}

"********************************************************************** Main{{{
function! neurun#Run() abort
  if s:startup
    let s:cb = {
          \ 'on_stdout': function('s:OutCB'),
          \ 'on_stderr': function('s:ErrCB'),
          \ 'on_exit': function('s:ExitCB'),
          \ }
    let s:autosave = get(g:, 'runner.autosave', 2)
    let s:startup = 0

    call s:Highlight()
  endif

  if s:autosave == 1
    silent execute 'w'
  elseif s:autosave == 2
    silent execute 'wa'
  endif

  if filereadable('MAINFILE')  " Workspace
    let l:ft = readfile('MAINFILE')[1]
  else
    let l:ft = &filetype
  endif

  if l:ft ==? 'markdown'
    call s:JobStart(s:RunMarkdown())
  elseif l:ft ==? 'python'
    call s:JobStart(s:RunPython())
  endif
endfunction

function! neurun#Stop() abort
  call s:JobStop()
endfunction

function! neurun#ClearQF() abort
  call setqflist([], 'r')
  call s:DoAutoCmd('Clear')
endfunction

function! neurun#ToggleQF() abort
  if s:qfopened
    silent execute 'cclose'
    let s:qfopened = 0
  else
    silent execute 'copen'
    let s:qfopened = 1
  endif
endfunction
"}}}

let &cpoptions = s:save_cpo
unlet s:save_cpo
