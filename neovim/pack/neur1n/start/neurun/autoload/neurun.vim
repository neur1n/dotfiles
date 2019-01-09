scriptencoding utf-8

let s:save_cpo = &cpoptions
set cpoptions&vim


let s:autosave = 2  " 0: do not; 1: save current buffer; 2: save all
let s:curjob = 0
let s:start_stamp = 0
let s:cb = neurun#cb#Callbacks()

"********************************************************************** Main{{{
function! neurun#Run() abort
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
    " call s:JobStart(neurun#cmd#markdown#Run())
    call neurun#job#Start(neurun#cmd#markdown#Run(), s:cb)
  elseif l:ft ==? 'python'
    " call s:JobStart(neurun#cmd#python#Run())
    call neurun#job#Start(neurun#cmd#python#Run(), s:cb)
  endif
endfunction

function! neurun#Stop() abort
  call neurun#job#Stop()
  " call s:JobStop()
endfunction
"}}}

"*************************************************************** Job Control{{{
function! s:JobStart(cmd) abort
  if has('nvim')
    let s:curjob = jobstart(a:cmd, s:cb)
  else
    let s:curjob = job_start(a:cmd, s:cb)
  endif

  if s:curjob > 0
    let s:start_stamp = reltime()
    call neurun#status#Set('Running ', 'i')
    call neurun#qf#Append(join(a:cmd))
    call neurun#action#DoAutoCmd('Action')
    " call neurun#action#DoAutoCmd('Start')
  elseif s:curjob == 0
    call neurun#status#Set('Failed ✘', 'e')
    call neurun#qf#Append(join(a:cmd).': Invalid arguments or job table is full.')
    call neurun#action#DoAutoCmd('Action')
    " call neurun#action#DoAutoCmd('Fail')
  elseif s:curjob == -1
    call neurun#status#Set('Failed ✘', 'e')
    call neurun#qf#Append(join(a:cmd).': Command is not executable.')
    call neurun#action#DoAutoCmd('Action')
    " call neurun#action#DoAutoCmd('Fail')
  else
    call neurun#status#Set('Failed ✘', 'e')
    call neurun#qf#Append(join(a:cmd).': Unknown failure.')
    call neurun#action#DoAutoCmd('Action')
    " call neurun#action#DoAutoCmd('Fail')
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

    call neurun#status#Set('Stopped ', 'w')

    unlet s:curjob
    call neurun#action#DoAutoCmd('Action', 1)
    " call neurun#action#DoAutoCmd('Stop')
  endif
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
