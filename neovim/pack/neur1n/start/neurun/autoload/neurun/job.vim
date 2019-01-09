scriptencoding utf-8

function! neurun#job#Start(cmd, cb) abort
  if has('nvim')
    let s:curjob = jobstart(a:cmd, a:cb)
  else
    let s:curjob = job_start(a:cmd, a:cb)
  endif

  if s:curjob > 0
    call neurun#job#Timer('start')
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
endf

function! neurun#job#Stop() abort
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

    unlet s:curjob

    call neurun#status#Set('Stopped ', 'w')
    call neurun#action#DoAutoCmd('Action', 1)
    " call neurun#action#DoAutoCmd('Stop')
  endif
endf

let s:stamp = 0
function! neurun#job#Timer(action) abort
  if a:action ==# 'start'
    let s:stamp = reltime()
  endif

  if a:action ==# 'stop'
    let l:tick = reltimefloat(reltime(s:stamp))
    call neurun#qf#Append(printf('%f seconds elapsed.', l:tick))
  endif
endfunction
