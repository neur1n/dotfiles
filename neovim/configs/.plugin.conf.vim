scriptencoding utf-8

if has('win32')
    let s:source_path = '~/AppData/Local/nvim'
else
    let s:source_path = $HOME
endif

"------------------------------------------------------ <itchyny/lightline.vim>
set laststatus=2
set showtabline=2

if !exists('g:lightline')
    let g:lightline = {}
endif

let g:lightline = {
    \ 'active': {
    \     'left': [['mode', 'paste', 'spell'],
    \              ['gitbranch'],
    \              ['filename'],
    \              ['modified', 'readonly']],
    \     'right': [['linter_errors', 'trailing', 'linter_warnings'],
    \               ['lineinfo'],
    \               ['fileformat', 'fileencoding'],
    \               ['tagbar']],
    \ },
    \ 'colorscheme': 'solarized_flood',
    \ 'component': {
    \     'fileencoding': '%{&fenc ==# "utf-8" ? "":&fenc}',
    \     'fileformat': '%{&ff ==# "unix" ? "":&ff}',
    \     'lineinfo': '%4l/%L:%-2v',
    \     'readonly': '%{&readonly ? "":""}',
    \     'spell': '%{&spell ? "S":""}',
    \ },
    \ 'component_expand': {
    \     'buffers': 'lightline#bufferline#buffers',
    \     'linter_warnings': 'lightline#ale#warnings',
    \     'linter_errors': 'lightline#ale#errors',
    \     'trailing': 'lightline#trailing_whitespace#component',
    \ },
    \ 'component_function': {
    \     'gitbranch': 'gitbranch#name',
    \     'tagbar': 'lightline_tagbar#component',
    \ },
    \ 'component_type': {
    \     'buffers': 'tabsel',
    \     'linter_warnings': 'warning',
    \     'linter_errors': 'error',
    \     'trailing': 'warning',
    \ },
    \ 'separater': {
    \     'left': '', 'right': ''
    \ },
    \ 'subseparater': {
    \     'left': '|', 'right': '|',
    \ },
    \ 'tabline': {
    \     'left': [['buffers']], 'right': [['close']],
    \ },
\ }

let g:lightline#bufferline#show_number = 1
let g:lightline#trailing_whitespace#indicator = '☰'
let g:lightline_tagbar#format = '%s'
let g:lightline_tagbar#flags = ''

let g:lightline.mode_map = {
    \ 'n': 'N',
    \ 'i': 'I',
    \ 'r': 'R',
    \ 'R': 'R',
    \ 'v': 'V',
    \ 'V': 'V',
    \ "\<C-v>": 'V',
    \ 'c': 'C',
    \ 's': 'S',
    \ 'S': 'S',
    \ "\<C-s>": 'S',
    \ 't': 'TERMINAL',
    \ }
"-------------------------------------------------------------- <lervag/vimtex>
let g:vimtex_view_general_viewer = 'E:\ProgramFiles\SumatraPDF\SumatraPDF.exe'
let g:vimtex_view_general_options
        \ = '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'
let g:vimtex_latexmk_options =
        \'xelatex -verbose -file-line-error -synctex=1'.
        \'-shell-escape -interaction=nonstopmode $*'

function SetupVimtexForNCM()
    autocmd!
    autocmd User CmSetup call cm#register_source({
        \ 'name' : 'vimtex',
        \ 'priority': 8,
        \ 'scoping': 1,
        \ 'scopes': ['tex'],
        \ 'abbreviation': 'tex',
        \ 'cm_refresh_patterns': g:vimtex#re#ncm,
        \ 'cm_refresh': {'omnifunc': 'vimtex#complete#omnifunc'},
        \ })
endfunction
autocmd BufRead *.tex :call SetupVimtexForNCM()

" let g:tex_flavor = 'latex'
" " let g:latex_viewer='SumatraPDF -reuse-instance -inverse-search '.
" "         \ '"gvim --servername '.v:servername.' --remote-send \"^<C-\^>^<C-n^>'.
" "         \ ':execute ''drop ''.fnameescape(''\%f'')^<CR^>:\%l^<CR^>:normal\! zzzv^<CR^>'.
" "         \ ':call remote_foreground('''.v:servername.''')^<CR^>\""'
" let g:vimtex_view_general_options  =
"         \'-reuse-instance -forward-search "\"'.$VIMRUNTIME.
"         \'\gvim.exe\" -n --remote-silent +\%l \"\%f\""  @tex @line @pdf'
"-------------------------------------------------------- <luochen1990/rainbow>
nnoremap <leader>rt :RainbowToggle<CR>
let g:rainbow_active = 1
"---------------------------------------------------------- <majutsushi/tagbar>
nnoremap <leader>tb :TagbarOpenAutoClose<CR>
let g:tagbar_iconchars = ['', '']
let g:tagbar_show_linenumbers = -1
let g:tagbar_silent = 1
let g:tagbar_sort = 0
"let g:tagbar_autoclose = 1
"--------------------------------------------------------- <mhinz/vim-startify>
let g:startify_fortune_use_unicode = 1
let g:startify_session_dir = s:source_path.'/recovery/session'

if strftime('%H') % 3 == 0
    let g:ascii = startify#fortune#boxed()
elseif strftime('%H') < 12
    let g:ascii = [
                   \ ' _____             _                  __ ',
                   \ '|     |___ ___ ___|_|___ ___       __|  |',
                   \ '| | | | . |  _|   | |   | . | _   |  |  |',
                   \ '|_|_|_|___|_| |_|_|_|_|_|_  || |  |_____|',
                   \ '                        |___||_|         '
                   \]
elseif strftime('%H') < 18
    let g:ascii = [
                   \ ' _____ ___ _                                    __ ',
                   \ '|  _  |  _| |_ ___ ___ ___ ___ ___ ___       __|  |',
                   \ '|     |  _|  _| -_|  _|   | . | . |   | _   |  |  |',
                   \ '|__|__|_| |_| |___|_| |_|_|___|___|_|_|| |  |_____|',
                   \ '                                       |_|         '
                   \]
else
    let g:ascii = [
                   \ ' _____             _                  __ ',
                   \ '|   __|_ _ ___ ___|_|___ ___       __|  |',
                   \ '|   __| | | -_|   | |   | . | _   |  |  |',
                   \ '|_____|\_/|___|_|_|_|_|_|_  || |  |_____|',
                   \ '                        |___||_|         '
                   \]
endif

if strftime('%H') < 12
    let g:animal = [
                    \ '       o',
                    \ '        o   ^__^',
                    \ '         o  (oo)\_______',
                    \ '            (__)\       )\/\',
                    \ '                ||----w |',
                    \ '                ||     ||',
                    \ ]
elseif strftime('%H') < 18
    let g:animal = [
                    \ '       o',
                    \ '        o    ____',
                    \ '         o  /    \',
                    \ '           | ^__^ |',
                    \ '           | (oo) |______',
                    \ '           | (__) |      )\/\',
                    \ '            \____/|----w |',
                    \ '                 ||     ||'
                    \ ]
else
    let g:animal = [
                     \ '       o',
                     \ '        o   \_\_    _/_/',
                     \ '         o      \__/',
                     \ '                (oo)\_______',
                     \ '                (__)\       )\/\',
                     \ '                    ||----w |',
                     \ '                    ||     ||'
                     \ ]
endif
let g:startify_custom_header = map(g:ascii + g:animal, "\"   \".v:val")
"---------------------------------------------------------------- <ncm-2/ncm-2>
augroup NCM2
    autocmd BufEnter * call ncm2#enable_for_buffer()
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
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
" imap <backspace> <backspace><Plug>(ncm2_auto_trigger)
"------------------------------------------------------------ <neomake/neomake>
" call neomake#configure#automake('nrwi', 500)
" let g:neomake_error_sign['text'] = '‼'
" let g:neomake_warning_sign['text'] = '⚡'
"----------------------------------------------------------- <SirVer/ultisnips>
let g:UltiSnipsExpandTrigger = '<C-s>'
"------------------------------------------------------------------- <w0rp/ale>
let g:ale_sign_column_always = 1
let g:ale_sign_error = '‼'
let g:ale_sign_warning = '⚡'
nnoremap <Leader>at :ALEToggle<CR>
nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)
