"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Customized by Jihang                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set fileformat=unix    " the following two make Vim create unix file by default
set fileformats=unix,dos

"=========================================================== <set vim language>
let $LANG = 'en'                                         " set message language
set langmenu=en                                             " set menu language

"========================================================= <Comment Formatting>
augroup comment_format
    autocmd FileType * set fo-=ro       " turn off insertion of comment leaders
    autocmd FileType * set fo+=j   " remove a comment leader when joining lines
augroup END

"================================================================ <UI Settings>
if has('gui_running')
    nnoremap <C-F9> :if &go=~#'L'<Bar>set go-=L<Bar>else<Bar>set go+=L<Bar>endif<CR>
    nnoremap <C-F10> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>
    set guioptions-=T
    set guioptions-=m
    set guioptions-=L
    set guioptions-=r
endif

if has('syntax')
    syntax on
    if has('gui_running')
        set background=dark
        colorscheme solarized
        let g:solarized_contrast="high"
    else
        colorscheme molokai
    endif
endif

"======================================================================= <Misc>
augroup pwd
    au BufEnter * silent! lcd %:p:h                            " auto cd to pwd
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

if has('mouse')
    set mouse=a
endif

"=================================================================== <Encoding>
if has('multi_byte')
    if &termencoding ==# ''
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    set fileencodings=utf-8,gbk,gb2312,gb18030
endif

"==================================================================== <General>
set autoindent                                           " set auto indentation
set backspace=indent,start                       " for vim-latex, see issue #53
set colorcolumn=80                                          " show right margin
set cursorline                                          " highlight current row
set expandtab shiftwidth=4 softtabstop=4     " set <Tab> width to be 4 <space>s
set tabstop=4                                " make real <Tab> to be width of 4
set hlsearch
set iminsert=0 imsearch=0                                " make IME more usable
set foldmethod=indent                      " fold code according to indentation
set foldlevelstart=99                              " start with no folds closed
set guifont=mononoki\ NF:h10                                 " set default font
set incsearch                                              " incremental search
set lines=30 columns=120                                  " initial window size
set linespace=0                                         " set line spacing to 0
set number                                                   " show line number
set relativenumber                                       " relative line number
set showcmd                                                 " show pressed keys
set wildmenu                                 " show possible matches when <Tab>
set tags+=../tags

augroup VCenterCursor
  au!
  au BufEnter,WinEnter,WinNew,VimResized *,*.*
        \ let &scrolloff=winheight(win_getid())/3
augroup END

"================================================================== <Splitting>
set splitright                                            " split on right side
set splitbelow                                                 " split on below

"================================================================= <File Types>
"au BufRead,BufNewFile *.bug setf bug
augroup file_types
    au BufRead,BufNewFile *.nim setf nim
    au BufRead,BufNewFile *.note setf note
    au BufRead,BufNewFile *.tut setf tut
    au BufRead,BufNewFile *.oct setf octave
augroup END

"=========================================================== <Backup Directory>
set backup
set backupdir=E:\ProgramFiles\Vim\recovery\backup

"============================================================= <netrw Settings>
let g:netrw_winsize=15                     " set explorer window width to be 30
let g:netrw_liststyle=3                         " set explorer to be tree style

"================================================================ <Key Mapping>
"----------------------------------------------------------------- General
"                                                          disable Ex mode
map Q <nop>

"      remap F1 to esc, also need to disable F1 of gnome terminal manually
map <F1> <Esc>
imap <F1> <Esc>

"                                                         toggle read only
function ToggleReadOnly()
    if &readonly == 1
        setl noreadonly
        if has('conceal')
            setl conceallevel=2 cocu=i
        endif
    else
        setl readonly
        if has('conceal')
            setl conceallevel=2 cocu=cn
        endif
    endif
endfunction
nnoremap <C-F1> :call ToggleReadOnly()<CR>

"                                         toggle current line highlighting
noremap <C-F2> :set cursorline! nocursorline?<CR>

"                                               toggle search highlighting
noremap <C-F3> :set hlsearch! hlsearch?<CR>

"                                                        toggle spellcheck
nnoremap <C-F4> :set spell! spelllang=en_us<CR>

"                                              toggle relative line number
function ToggleRelativeLineNumber()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunction
nnoremap <C-F5> :call ToggleRelativeLineNumber()<CR>

"      insert a new line without entering insert mode (shift-enter, enter)
nnoremap <CR> o<Esc>
nnoremap <S-CR> O<Esc>

"                                         split open definition (for tags)
nnoremap <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"                    go to a line and make it one the center of the screen
nnoremap G Gzz

"                              modify the behavior of j & k in normal mode
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

"                                           move over panes in normal mode
nnoremap <Left> <C-W>h
nnoremap <Right> <C-W>l
nnoremap <Down> <C-W>j
nnoremap <Up> <C-W>k

"                                                               move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==

"                                               move cursor in insert mode
inoremap <A-h> <Left>
inoremap <A-l> <Right>
inoremap <A-j> <Down>
inoremap <A-k> <Up>

"                                                    delete hidden buffers
function DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction
nnoremap <leader>dh :call DeleteHiddenBuffers()<CR>

"                                  automatically append closing characters
inoremap ( ()<Left>
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap [ []<Left>
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap { {}<Left>
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"

"------------------------------------------------------------ Run or Build
"                                                        run Python script
function RunPythonScript()
    "if filereadable("main.py")
    "    wa
    "    silent !python main.py
    if filereadable('MAINFILE')
        let l:file_id = readfile('MAINFILE')
        "silent !python $(file_id[0])
        execute 'wa'
        execute 'silent !python '.l:file_id[0]
    else
        "wa
        "silent !python %
        execute 'wa'
        execute 'silent !python %'
    endif
endfunction
nnoremap <leader>py :call RunPythonScript()<CR>
nnoremap <leader>pp :wa<CR>:!python %<CR>

"                                                            keil commands
function MakeKeilTarget(options)
    let l:target = ''

    if !empty(glob('*.uvprojx'))
        let l:target =  glob('*.uvprojx')
    elseif !empty(glob('../../*.uvprojx'))
        let l:target =  glob('../../*.uvprojx')
    endif

    if !empty(l:target)
        execute ':silent !uv4 '.a:options.l:target.' -o "\%TEMP\%/log.txt"'
        execute ':sp $TEMP/log.txt'
    else
        echo 'Target not found!'
    endif
endfunction
nnoremap <leader>kb :call MakeKeilTarget('-b')<CR>
nnoremap <leader>kr :call MakeKeilTarget('-cr ')<CR>
nnoremap <leader>kf :call MakeKeilTarget('-f ')<CR>
nnoremap <leader>kd :call MakeKeilTarget('-d ')<CR>

"============================================================== <Abbreviations>
cabbrev tw %s/\s\+$//gc
cabbrev st %s/\t/    /gc
inoreabbrev edc // Edited by Jihang

"============================================================= <File Templates>
augroup templates
  au!
  autocmd BufNewFile *.* silent! execute '0r E:\ProgramFiles\Vim\vimfiles\templates\skeleton.'.expand("<afile>:e")
augroup END

"==================================================================== <Plugins>
call plug#begin('E:\ProgramFiles\Vim\vimfiles\plugged')
Plug 'honza/vim-snippets'
Plug 'lervag/vimtex'
Plug 'luochen1990/rainbow'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-startify'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'roxma/nvim-completion-manager'
Plug 'roxma/ncm-clang'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'triglav/vim-visual-increment'
Plug 'vim-airline/vim-airline'
" Plug 'vim-latex/vim-latex'
Plug 'w0rp/ale'
Plug 'wesQ3/vim-windowswap'
Plug 'will133/vim-dirdiff'
" load vim-devicons at the end
Plug 'ryanoasis/vim-devicons'
call plug#end()

"====================================================== <Plugin configurations>
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
"--------------------------------------------------- <vim-latex/vim-latex>
"set shellslash
"set grepprg=grep\ -nH\ $*
"let Tex_FoldedSections=''
"let Tex_FoldedEnvironments=''
"let Tex_FoldedMisc=''
"let g:tex_flavor='latex'
"let g:Tex_CompileRule_pdf = 'pdflatex -shell-escape -interaction=nonstopmode $*'
""let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
""let g:Tex_CompileRule_pdf = 'texliveonfly -interaction=nonstopmode $*'
"let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_MultipleCompileFormats='pdf,aux'
"let g:Tex_ViewRule_pdf = 'E:\ProgramFiles\SumatraPDF\SumatraPDF.exe'
"
"function CompileXeTex()               " use xelatex to compile temporarily
"    let l:oldCompileRule=g:Tex_CompileRule_pdf
"    let g:Tex_CompileRule_pdf = 'xelatex -interaction=nonstopmode $*'
"    call Tex_RunLaTeX()
"    let g:Tex_CompileRule_pdf=l:oldCompileRule
"endfunction
"nnoremap <Leader>lx :<C-U>call CompileXeTex()<CR>
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


"=========================================================== <Commented Things>
"set fileencodings=utf-8,gbk,gb2312,gb18030          "| show chinese characters
"set termencoding=utf-8
"set encoding=prc

"setglobal bomb -> was after setglobal fileencoding=utf-8

"set selection=exclusive                             | default = inclusive
"set textwidth=79                                    | wrap at 79
"au FileType tex setlocal tw=79                      | wrap at 79 for tex file
"au InsertLeave * hi StatusLine ctermfg=231 ctermbg=241 cterm=bold guifg=#f8f8f2 guibg=#64645e gui=bold
"au InsertEnter * hi StatusLine ctermfg=235 ctermbg=112 cterm=bold guifg=#262626 guibg=#87af00 gui=bold

"set shiftwidth=4 tabstop=4                          | set <Tab> width to be 4 <space>s: hard tab

"set dir=E:\Program\ Files\Vim\recovery\swap         | setup a swap file folder

"let g:Tex_BibtexFlavor = 'biber'
"let g:Tex_CompileRule_pdf = 'pdflatex --synctex=-1 -src-specials -interaction=nonstopmode $*'
"let g:Tex_ViewRule_pdf = 'E:\Program Files\Foxit Software\Foxit Reader\FoxitReader.exe'
