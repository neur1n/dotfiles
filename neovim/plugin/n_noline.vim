scriptencoding utf-8

if exists('g:loaded_n_noline')
  finish
endif

let g:loaded_n_noline = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

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

let &cpoptions = s:save_cpo
unlet s:save_cpo
