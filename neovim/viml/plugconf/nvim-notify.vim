scriptencoding utf-8

lua require'plugconf.notify'.setup()

augroup notify
  autocmd!
  autocmd User AsyncRunPre lua require'plugconf.notify'.re_notify('AsyncRun', 'Starting', 'info')
  autocmd User AsyncRunStart lua require'plugconf.notify'.re_notify('AsyncRun', 'Running', 'info')
  autocmd User AsyncRunStop lua require'plugconf.notify'.re_notify('AsyncRun', 'Stopped', 'info')
  autocmd User AsyncRunInterrupt lua require'plugconf.notify'.re_notify('AsyncRun', 'Interruptted', 'warning')
augroup END
