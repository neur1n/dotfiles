scriptencoding utf-8

lua << EOF
require("telescope").setup()
EOF

nnoremap <Leader>sb <Cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <Leader>sc <Cmd>lua require('telescope.builtin').command_history()<CR>
nnoremap <Leader>sf <Cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <Leader>sg <Cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <Leader>sh <Cmd>lua require('telescope.builtin').oldfiles()<CR>
nnoremap <Leader>sr <Cmd>lua require('telescope.builtin').find_files({cwd=vim.fn['neutil#buf#RootDirectory']()})<CR>
nnoremap <Leader>ss <Cmd>lua require('telescope.builtin').search_history()<CR>
