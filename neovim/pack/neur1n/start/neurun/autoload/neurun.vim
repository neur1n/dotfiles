scriptencoding utf-8

let s:save_cpo = &cpoptions
set cpoptions&vim


let s:autosave = 2  " 0: do not; 1: save current buffer; 2: save all
let s:cb = neurun#cb#Callbacks()

function! neurun#Run(...) abort
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

  if a:0
    call neurun#job#Start(a:000, s:cb)
  elseif l:ft ==? 'markdown'
    call neurun#job#Start(neurun#cmd#markdown#Run(), s:cb)
  elseif l:ft ==? 'python'
    call neurun#job#Start(neurun#cmd#python#Run(), s:cb)
  endif
endfunction

function! neurun#Stop() abort
  call neurun#job#Stop()
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
