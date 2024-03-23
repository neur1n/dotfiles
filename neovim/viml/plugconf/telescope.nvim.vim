scriptencoding utf-8

lua << EOF
require("telescope").setup{
  extensions = {
    fzf = {
      fuzzy = true,
      case_mode = "smart_case",
      override_file_sorter = true,
      override_generic_sorter = true,
    },
  }
}

require("telescope").load_extension("fzf")
EOF

nnoremap <silent> <Leader>fb <Cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <silent> <Leader>fc <Cmd>lua require('telescope.builtin').command_history()<CR>
nnoremap <silent> <Leader>ff <Cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <silent> <Leader>fg <Cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <silent> <Leader>fh <Cmd>lua require('telescope.builtin').oldfiles()<CR>
nnoremap <silent> <Leader>fr <Cmd>lua require('telescope.builtin').find_files({cwd=vim.fn['neutil#buf#RootDirectory']()})<CR>
nnoremap <silent> <Leader>fs <Cmd>lua require('telescope.builtin').search_history()<CR>
" nnoremap <silent> <Leader>ft <Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>
nnoremap <silent> <Leader>ft <Cmd>CocList --auto-preview outline<CR>
