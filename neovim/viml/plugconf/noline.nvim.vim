scriptencoding utf-8

set showtabline=2

function! s:Redraw() abort
  lua require'plugconf.noline.statusline'.redraw()
  lua require'plugconf.noline.tabline'.redraw()
  " lua require'plugconf.noline.winbar'.redraw()
endfunction

call s:Redraw()

augroup noline
  autocmd!
  autocmd BufEnter,FileChangedShellPost,FileType,WinEnter * lua require'plugconf.noline.statusline'.update()
  autocmd BufEnter * lua require'plugconf.noline.tabline'.update()
  " autocmd WinEnter * lua require'plugconf.noline.winbar'.update()
  autocmd ColorScheme neucs call <SID>Redraw()
augroup END
