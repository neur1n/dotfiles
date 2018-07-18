if has('win32')
    let s:source_path = '~/AppData/Local/nvim'
else
    let s:source_path = $HOME
endif

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
if has('syntax')
    syntax on
    set background=dark
    " set termguicolors
    " colorscheme molokai
    colorscheme solarized
    let g:solarized_contrast='low'
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
set iminsert=0 imsearch=0                                " make IME more usable
set foldmethod=indent                      " fold code according to indentation
set foldlevelstart=99                              " start with no folds closed
" set guifont=mononoki\ NF:h10                                 " set default font
" set nohlsearch                                         " no search highlighting
set lines=30 columns=120                                  " initial window size
set linespace=0                                         " set line spacing to 0
set number                                                   " show line number
set relativenumber                                       " relative line number
set showcmd                                                 " show pressed keys
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
if has('win32')
    set backupdir=~/AppData/Local/nvim/recovery/backup
else
    set backupdir=$HOME/recovery/backup
endif

"============================================================= <netrw Settings>
let g:netrw_winsize=15                     " set explorer window width to be 30
let g:netrw_liststyle=3                         " set explorer to be tree style

"============================================================= <File Templates>
augroup templates
    au!
    autocmd BufNewFile *.* silent! execute '0r '.s:source_path.'/templates/skeleton.'.expand("<afile>:e")
augroup END

"======================================================= <Colorscheme Overrule>
exec 'source '.s:source_path.'/configs/.colorscheme.vim'

"================================================================ <Key Mapping>
exec 'source '.s:source_path.'/configs/.keymap.vim'

"============================================================== <Abbreviations>
exec 'source '.s:source_path.'/configs/.abbrev.vim'

"==================================================================== <Plugins>
exec 'source '.s:source_path.'/configs/.plugin.vim'

"====================================================== <Plugin configurations>
exec 'source '.s:source_path.'/configs/.plugin.conf.vim'
