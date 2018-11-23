scriptencoding utf-8

"********************************************************* {luochen1990/rainbow
nnoremap <leader>rp :RainbowToggle<CR>
let g:rainbow_active = 1
" }

"*********************************************************** {majutsushi/tagbar
nnoremap <leader>tb :TagbarOpenAutoClose<CR>
let g:tagbar_iconchars = ['►', '▼'] " 
let g:tagbar_show_linenumbers = -1
let g:tagbar_silent = 1
let g:tagbar_sort = 0
"let g:tagbar_autoclose = 1
" }

"******************************************************************************
"                                                            mhinz/vim-startify
"******************************************************************************
let g:startify_fortune_use_unicode = 1
let g:startify_session_dir = '$VIMCONFIG/recovery/session'

if strftime('%M') % 3 == 0
    let b:greeting = startify#fortune#boxed()
elseif strftime('%M') % 3 == 1
    let b:greeting = b:greetings['hello']
else
    let b:greeting = b:greetings['vim']
endif

if strftime('%H') < 12
    let b:animal = b:animals['cow']
elseif strftime('%H') < 18
    let b:animal = b:animals['lion']
else
    let b:animal = b:animals['moose']
endif
let g:startify_custom_header = map(b:greeting + b:animal, "\"   \".v:val")

"******************************************************************************
"                                                               morhetz/gruvbox
"******************************************************************************
" let g:gruvbox_improved_strings=1
" let g:gruvbox_contrast_dark='hard'
" let g:gruvbox_improved_warnings=1
let g:gruvbox_italic=1
let g:gruvbox_underline=1
let g:gruvbox_undercurl=1

"******************************************************************************
"                                                             neoclide/coc.nvim
"******************************************************************************
set completeopt=menuone,noinsert,noselect
function! s:check_back_space() abort
  let a:col = col('.') - 1
  return !a:col || getline('.')[a:col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" : coc#refresh()
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-reference)
nmap <leader>rn <Plug>(coc-rename)
" nmap <C-p> <Plug>(coc-diagnostic-prev)
" nmap <C-n> <Plug>(coc-diagnostic-next)

" highlight link CocErrorSign Error_
" highlight link CocWarningSign Warning_
" highlight link CocInfoSign Warning_
" highlight link CocHintSign Warning_


"******************************************************************************
"                                                              SirVer/ultisnips
"******************************************************************************
let g:UltiSnipsExpandTrigger = '<C-s>'
" let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsJumpForwardTrigger = '<C-f>'
let g:UltiSnipsJumpBackwardTrigger = '<C-b>'

"******************************************************************************
"                                                               nermake/nermake
"******************************************************************************
" call neomake#configure#automake({
" \   'TextChanged': {},
" \   'InsertLeave': {},
" \   'BufWritePost': {'delay': 0},
" \   'BufWinEnter': {},
" \ }, 500)

"******************************************************************************
"                                                                      w0rp/ale
"******************************************************************************
"⚡ 
" let g:ale_lint_on_insert_leave = 1
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_sign_column_always = 1

if !exists('g:ale_linters')
    let g:ale_linters = {}
endif
if !exists('g:ale_fixers')
    let g:ale_linters = {}
endif

let g:ale_linters = {
    \ 'c': ['clang', 'clangd'],
    \ 'cpp': ['cpplint', 'clang', 'clangd'],
    \ 'python': ['pyls'],
\ }
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'c': ['cpplint'],
    \ 'cpp': ['cpplint'],
    \ 'python': ['yapf', 'autopep8'],
\ }

let g:ale_c_clang_executable='clang-7'
let g:ale_c_clangd_executable='clangd-7'
let g:ale_cpp_clang_executable='clang-7'
let g:ale_cpp_clangd_executable='clangd-7'

let g:ale_sign_error = '✘'
let g:ale_sign_warning = ''
let g:ale_echo_msg_format = '[%linter%] %s'
nnoremap <Leader>al :ALEToggle<CR>
nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)
nnoremap <silent> <leader>gd :ALEGoToDefinitionInTab<CR>
nnoremap <silent> <leader>gr :ALEFindReference<CR>
