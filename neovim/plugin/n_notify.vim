scriptencoding utf-8

if exists('g:loaded_n_notify')
  finish
endif

let g:loaded_n_notify = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

lua require'plugconf.notify'.setup()

augroup notify
  autocmd!
  autocmd User AsyncRunPre lua require'plugconf.notify'.re_notify('AsyncRun', 'Starting', 'info')
  autocmd User AsyncRunStart lua require'plugconf.notify'.re_notify('AsyncRun', 'Running', 'info')
  autocmd User AsyncRunStop lua require'plugconf.notify'.re_notify('AsyncRun', 'Stopped', 'info')
  autocmd User AsyncRunInterrupt lua require'plugconf.notify'.re_notify('AsyncRun', 'Interruptted', 'warning')
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
