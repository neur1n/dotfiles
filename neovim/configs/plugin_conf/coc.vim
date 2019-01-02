scriptencoding utf-8

"*********************************************************** {neoclide/coc.nvim
set completeopt=menuone,noinsert,noselect
" set hidden

function! s:check_back_space() abort
  let a:col = col('.') - 1
  return !a:col || getline('.')[a:col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" : coc#refresh()
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-reference)
nmap <leader>rn <Plug>(coc-rename)
imap <C-s> <Plug>(coc-snippets-expand)

" nmap <C-p> <Plug>(coc-diagnostic-prev)
" nmap <C-n> <Plug>(coc-diagnostic-next)
"}
