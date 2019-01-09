scriptencoding utf-8

function! neurun#cb#Callbacks() abort
  return {
        \ 'on_stdout': function('s:OutCB'),
        \ 'on_stderr': function('s:ErrCB'),
        \ 'on_exit': function('s:ExitCB'),
        \ }
endfunction

function! s:OutCB(jobid, data, event) abort
  let l:joined = s:JoinData(a:data)
  if l:joined !=# ''
    call neurun#qf#Append(l:joined)
  endif
endfunction

function! s:ErrCB(jobid, data, event) abort
  let l:joined = s:JoinData(a:data)
  if l:joined !=# ''
    let l:msg = printf('Shell returns %s. (Extra: %s)', v:shell_error, l:joined)
  else
    let l:msg = printf('Shell returns %s.', v:shell_error)
  endif

  call neurun#qf#Append(l:msg)

  if !neurun#action#IsInterrupted()
    if v:shell_error == 0 && l:joined ==# ''
      call neurun#status#Set('Finished ✓', 'h')
      call neurun#action#DoAutoCmd('Action')
    else
      call neurun#status#Set('Error ✘', 'e')
      call neurun#action#DoAutoCmd('Action', 1)
    endif
  endif

endfunction

function! s:ExitCB(jobid, data, event) abort
  call neurun#qf#Append('Exited.')
  call neurun#job#Timer('stop')
endfunction

function! s:JoinData(data) abort
  let l:joined = ''
  for i in a:data
    let l:joined .= i
  endfor
  return l:joined
endfunction
