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
let g:vimtex_view_general_viewer = 'E:\ProgramFiles\SumatraPDF\SumatraPDF.exe'
let g:vimtex_view_general_options
        \ = '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'
let g:vimtex_latexmk_options =
        \'xelatex -verbose -file-line-error -synctex=1'.
        \'-shell-escape -interaction=nonstopmode $*'

" let g:tex_flavor = 'latex'
" " let g:latex_viewer='SumatraPDF -reuse-instance -inverse-search '.
" "         \ '"gvim --servername '.v:servername.' --remote-send \"^<C-\^>^<C-n^>'.
" "         \ ':execute ''drop ''.fnameescape(''\%f'')^<CR^>:\%l^<CR^>:normal\! zzzv^<CR^>'.
" "         \ ':call remote_foreground('''.v:servername.''')^<CR^>\""'
" let g:vimtex_view_general_options  =
"         \'-reuse-instance -forward-search "\"'.$VIMRUNTIME.
"         \'\gvim.exe\" -n --remote-silent +\%l \"\%f\""  @tex @line @pdf'

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
let g:startify_session_dir = '$HOME\vimfiles\recovery\session'

if strftime('%H') % 3 == 0
    let b:greeting = startify#fortune#boxed()
elseif strftime('%H') % 3 == 1
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
"                                                                   ncm-2/ncm-2
"******************************************************************************
augroup NCM2
    autocmd InsertEnter * call ncm2#enable_for_buffer()
    au User Ncm2Plugin call ncm2#register_source({
        \ 'name' : 'vimtex',
        \ 'priority': 1,
        \ 'subscope_enable': 1,
        \ 'complete_length': 1,
        \ 'scope': ['tex'],
        \ 'matcher': {'name': 'combine',
        \           'matchers': [
        \               {'name': 'abbrfuzzy', 'key': 'menu'},
        \               {'name': 'prefix', 'key': 'word'},
        \           ]},
        \ 'mark': 'tex',
        \ 'word_pattern': '\w+',
        \ 'complete_pattern': g:vimtex#re#ncm,
        \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
\ })
augroup END
set completeopt=noinsert,menuone,noselect
inoremap <silent> <expr> <CR> ((pumvisible() && empty(v:completed_item)) ?  "\<C-y>\<CR>" : (!empty(v:completed_item) ? ncm2_ultisnips#expand_or("", 'n') : "\<CR>" ))
" inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"******************************************************************************
"                                                              SirVer/ultisnips
"******************************************************************************
imap <silent> <expr> <C-s> ncm2_ultisnips#expand_or("\<Plug>(ultisnips_expand)", 'm')
smap <C-s> <Plug>(ultisnips_expand)
let g:UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
" let g:UltiSnipsJumpForwardTrigger	= '<c-j>'
" let g:UltiSnipsJumpBackwardTrigger	= '<c-k>'
let g:UltiSnipsRemoveSelectModeMappings = 0

"******************************************************************************
"                                                       vim-airline/vim-airline
"******************************************************************************
set laststatus=2                                      " show even only 1 window
let g:airline_detect_iminsert = 1
let g:airline_detect_spelllang = 0
let g:airline_powerline_fonts = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

if g:colors_name ==# 'solarized'
    let g:airline_theme = 'solarized_flood'
    " let g:solarized_flood_dam = 1
else
    let g:airline_theme = 'dark'
endif

let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }

" 
let g:airline_left_sep = ''
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = ''
let g:airline_right_alt_sep = '|'

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

"Ξ•☰
let g:airline_symbols = {
    \ 'branch': '',
    \ 'linenr': '',
    \ 'maxlinenr': '',
    \ 'notexists': '+',
    \ 'readonly': '',
    \ 'spell': 'S',
    \ 'whitespace': '☰'
\ }

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '' " 
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

let g:airline#extensions#whitespace#long_format = 'L(%s)'
let g:airline#extensions#whitespace#mixed_indent_format = 'MI(%s)'
let g:airline#extensions#whitespace#mixed_indent_file_format = 'MIF(%s)'
let g:airline#extensions#whitespace#trailing_format = 'T(%s)'

let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#excludes = ['log.txt']

let g:airline#extensions#ale#enabled = 1

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tagbar#enabled = 1

function AirlineOverrule()
    let g:airline_section_b = '%{gitbranch#name()}'
    let g:airline_section_x =
        \ airline#section#create_right(['windowswap', 'tagbar'])
    let g:airline_section_z = airline#section#create_right(['%4l/%L:%-2v'])
    let g:airline_section_warning =
        \ airline#section#create(['whitespace', 'ale_warning_count'])
    let g:airline_section_error = airline#section#create(['ale_error_count'])
endfunction

augroup airline_overrule
    " autocmd FileType c,cpp let g:airline#extensions#tagbar#enabled = 0
    autocmd User AirlineAfterInit call AirlineOverrule()
augroup END

"******************************************************************************
"                                                                      w0rp/ale
"******************************************************************************
"⚡ 
" let g:ale_lint_on_insert_leave = 1
" let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_column_always = 1
let g:ale_sign_error = ''
let g:ale_sign_warning = '⚡'
nnoremap <Leader>al :ALEToggle<CR>
nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)
