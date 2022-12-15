scriptencoding utf-8

augroup nu
  autocmd!
  autocmd FileType nu lua require'nu'.setup({complete_cmd_names = false})
augroup end
