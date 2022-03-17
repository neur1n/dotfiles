scriptencoding utf-8

"************************************************************* Neur1n/noline{{{
set showtabline=2

lua require'plugconf.noline.statusline'.render_c()
lua require'plugconf.noline.statusline'.render_nc()
lua require'plugconf.noline.tabline'.render()

augroup noline
  autocmd!
  autocmd BufEnter,ColorScheme,FileChangedShellPost,FileType,WinEnter * lua require'plugconf.noline.statusline'.update()
  autocmd BufEnter * lua require'plugconf.noline.tabline'.update()
augroup END
"}}}
