scriptencoding utf-8
"******************************************************************************
"                                                   iamcco/markdown-preview.vim
"******************************************************************************
let g:mkdp_refresh_slow = 1
nmap <silent> <leader>mp <Plug>MarkdownPreview
nmap <silent> <leader>ms <Plug>StopMarkdownPreview

"******************************************************************************
"                                                                 lervag/vimtex
"******************************************************************************
" let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_general_viewer = 'E:\ProgramFiles\SumatraPDF\SumatraPDF.exe'
let g:vimtex_view_general_options
    \ = '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'
let g:vimtex_latexmk_options =
    \ 'xelatex -verbose -file-line-error '.
    \ '-synctex=1 -shell-escape -interaction=nonstopmode $*'

if !exists('g:vimtex_compiler_latexmk')
    let g:vimtex_compiler_latexmk = {}
endif

let g:vimtex_compiler_latexmk = {
    \ 'build_dir': './build/',
    \ 'callback': 1,
    \ 'continuous': 0,
\ }

"******************************************************************************
"                                                           luochen1990/rainbow
"******************************************************************************
nnoremap <leader>rp :RainbowToggle<CR>
let g:rainbow_active = 1

"******************************************************************************
"                                                             majutsushi/tagbar
"******************************************************************************
nnoremap <leader>tb :TagbarOpenAutoClose<CR>
let g:tagbar_iconchars = ['►', '▼'] " 
let g:tagbar_show_linenumbers = -1
let g:tagbar_silent = 1
let g:tagbar_sort = 0
"let g:tagbar_autoclose = 1

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
let g:gruvbox_improved_warnings=1
let g:gruvbox_italic=1
let g:gruvbox_underline=1
let g:gruvbox_undercurl=1

"******************************************************************************
"                                                                   ncm-2/ncm-2
"******************************************************************************
" set completeopt=noinsert,menuone,noselect
"
" augroup ncm_tex
"     autocmd!
"     autocmd InsertEnter * call ncm2#enable_for_buffer()
"     autocmd Filetype tex call ncm2#register_source({
"         \ 'name': 'vimtex',
"         \ 'priority': 8,
"         \ 'scope': ['tex'],
"         \ 'matcher': {'name': 'combine',
"         \             'matchers': [
"         \                  {'name': 'abbrfuzzy', 'key': 'menu'},
"         \                  {'name': 'prefix', 'key': 'word'},
"         \             ]
"         \            },
"         \ 'mark': 'tex',
"         \ 'word_pattern': '\w+',
"         \ 'complete_pattern': g:vimtex#re#ncm2,
"         \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
"         \ })
" augroup END

" inoremap <silent> <expr> <CR> ((pumvisible() && empty(v:completed_item)) ?  "\<C-y>\<CR>" : (!empty(v:completed_item) ? ncm2_ultisnips#expand_or("", 'n') : "\<CR>" ))
" inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"******************************************************************************
"                                                             neoclide/coc.nvim
"******************************************************************************
" function! s:check_back_space() abort
"   let a:col = col('.') - 1
"   return !a:col || getline('.')[a:col - 1]  =~# '\s'
" endfunction

" inoremap <silent><expr> <TAB>
"     \ pumvisible() ? "\<C-n>" :
"     \ <SID>check_back_space() ? "\<TAB>" : coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" " inoremap <expr> <CR> pumvisible() ? "\<C-y>\<cr>" : "\<CR>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" nmap <leader>gd <Plug>(coc-definition)
" nmap <leader>gr <Plug>(coc-reference)
" nmap <leader>rn <Plug>(coc-rename)
" nmap <C-p> <Plug>(coc-diagnostic-prev)
" nmap <C-n> <Plug>(coc-diagnostic-next)

" highlight link CocErrorSign error
" highlight link CocWarningSign todo
" highlight link CocInfoSign todo
" highlight link CocHintSign todo

"******************************************************************************
"                                                          Shougo/deoplete.nvim
"******************************************************************************
let g:deoplete#enable_at_startup=1
call deoplete#custom#option({
    \ 'auto_complete_delay': 0,
    \ 'smart_case': v:true,
\ })
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

"******************************************************************************
"                                                              SirVer/ultisnips
"******************************************************************************
" imap <silent> <expr> <C-s> ncm2_ultisnips#expand_or("\<Plug>(ultisnips_expand)", 'm')
" smap <C-s> <Plug>(ultisnips_expand)
let g:UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
let g:UltiSnipsRemoveSelectModeMappings = 0
" let g:UltiSnipsJumpForwardTrigger = '<C-j>'
" let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

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
    \ 'python': ['pycodestyle', 'pyflakes', 'pyls'],
\ }
" let g:ale_linters = {
"     \ 'python': ['pyls'],
" \ }
let g:ale_fixers = {
    \ 'python': ['yapf', 'autopep8'],
\ }

let g:ale_sign_error = ''
let g:ale_sign_warning = ''
nnoremap <Leader>al :ALEToggle<CR>
nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)
nnoremap <silent> <leader>gd :ALEGoToDefinitionInTab<CR>
nnoremap <silent> <leader>gr :ALEFindReference<CR>
