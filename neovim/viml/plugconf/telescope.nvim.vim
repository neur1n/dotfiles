scriptencoding utf-8

lua << EOF
require("telescope").setup()
require("telescope").load_extension("coc")
EOF

nnoremap <silent> <Leader>sb <Cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <silent> <Leader>sc <Cmd>lua require('telescope.builtin').command_history()<CR>
nnoremap <silent> <Leader>sf <Cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <silent> <Leader>sg <Cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <silent> <Leader>sh <Cmd>lua require('telescope.builtin').oldfiles()<CR>
nnoremap <silent> <Leader>sr <Cmd>lua require('telescope.builtin').find_files({cwd=vim.fn['neutil#buf#RootDirectory']()})<CR>
nnoremap <silent> <Leader>ss <Cmd>lua require('telescope.builtin').search_history()<CR>

nnoremap <silent> <Leader>st <Cmd>Telescope coc document_symbols<CR>
