"--------------------------------------------------------- <lervag/vimtex>
let g:vimtex_view_general_viewer = 'E:\ProgramFiles\SumatraPDF\SumatraPDF.exe'
let g:vimtex_view_general_options
        \ = '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'
let g:vimtex_latexmk_options =
        \'xelatex -verbose -file-line-error -synctex=1'.
        \'-shell-escape -interaction=nonstopmode $*'

augroup my_cm_setup
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
augroup END

" let g:tex_flavor = 'latex'
" " let g:latex_viewer='SumatraPDF -reuse-instance -inverse-search '.
" "         \ '"gvim --servername '.v:servername.' --remote-send \"^<C-\^>^<C-n^>'.
" "         \ ':execute ''drop ''.fnameescape(''\%f'')^<CR^>:\%l^<CR^>:normal\! zzzv^<CR^>'.
" "         \ ':call remote_foreground('''.v:servername.''')^<CR^>\""'
" let g:vimtex_view_general_options  =
"         \'-reuse-instance -forward-search "\"'.$VIMRUNTIME.
"         \'\gvim.exe\" -n --remote-silent +\%l \"\%f\""  @tex @line @pdf'
"--------------------------------------------------- <luochen1990/rainbow>
nnoremap <C-F6> :RainbowToggle<CR>
let g:rainbow_active = 1
"----------------------------------------------------- <majutsushi/tagbar>
nnoremap <C-F7> :TagbarOpenAutoClose<CR>
let g:tagbar_iconchars = ['', '']
let g:tagbar_show_linenumbers = -1
let g:tagbar_silent = 1
let g:tagbar_sort = 0
"let g:tagbar_autoclose = 1
"---------------------------------------------------- <mhinz/vim-startify>
let g:startify_fortune_use_unicode = 1
let g:startify_session_dir = 'E:\ProgramFiles\Vim\recovery\session'

if strftime("%H") % 3 == 0
    let g:ascii = startify#fortune#boxed()
elseif strftime("%H") < 12
    let g:ascii = [
                   \ ' _____             _                  __ ',
                   \ '|     |___ ___ ___|_|___ ___       __|  |',
                   \ '| | | | . |  _|   | |   | . | _   |  |  |',
                   \ '|_|_|_|___|_| |_|_|_|_|_|_  || |  |_____|',
                   \ '                        |___||_|         '
                   \]
elseif strftime("%H") < 18
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

if strftime("%H") < 12
    let g:animal = [
                    \ '       o',
                    \ '        o   ^__^',
                    \ '         o  (oo)\_______',
                    \ '            (__)\       )\/\',
                    \ '                ||----w |',
                    \ '                ||     ||',
                    \ ]
elseif strftime("%H") < 18
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
"--------------------------------------- <nathanaelkane/vim-indent-guides>
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 4
"------------------------------------------------------ <SirVer/ultisnips>
let g:UltiSnipsExpandTrigger = '<C-s>'
"----------------------------------------- <roxma/nvim-completion-manager>
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"--------------------------------------------- <roxma/nvim-hug_neovim-rpc>
let g:python3_host_prog='E:\ProgramFiles\Python36\python.exe'
"----------------------------------------------- <vim-airline/vim-airline>
set laststatus=2                                 " show even only 1 window
let g:airline_detect_iminsert = 1
let g:airline_detect_spelllang = 0
let g:airline_powerline_fonts = 1
let g:airline_theme = 'dark'

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

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.spell = 'S'
let g:airline_symbols.branch = '' "
let g:airline_symbols.notexists = '+' "
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''"
let g:airline_symbols.maxlinenr = ''"
let g:airline_symbols.whitespace = 'Ξ' "

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ' ' "
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
" let g:airline#extensions#tabline#buffers_label = 'b'
" let g:airline#extensions#tabline#tabs_label = 't'
let g:airline#extensions#tabline#buffer_nr_show = 1

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tagbar#enabled = 0

let g:airline_section_z = '%{airline#util#wrap(airline#extensions#windowswap#get_status(),0)}%1p%% %#__accent_bold#%{g:airline_symbols.linenr}:%1l%#__restore__#%#__accent_bold#/%L %{g:airline_symbols.maxlinenr}%#__restore__#:%1v'
"-------------------------------------------------------------- <w0rp/ale>
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '' "
let g:ale_sign_warning = '⚡' "
let g:ale_lint_on_text_changed='normal'
nnoremap <Leader>s :ALEToggle<CR>
nmap <silent> <C-k> <Plug>(ale_next_wrap)
" let g:ale_linters = {
"     \   'c': ['clang'],
"     \   'cpp': ['clang++'],
"     \}
let g:ale_fixers = {
    \   'c': ['clang-format'],
    \   'cpp': ['clang-format'],
    \}
" autocmd BufEnter *.cpp,*.h,*.hpp,*.hxx let g:ale_cpp_clang_options = join(ncm_clang#compilation_info()['args'])
"------------------------------------------------ <ryanoasis/vim-devicons>
" let g:webdevicons_enable = 0
