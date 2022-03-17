scriptencoding utf-8

"************************************************************************ UI{{{
let $LANG='en'                                           " set message language
set langmenu=en                                             " set menu language
let g:netrw_browse_split=4                       " open file in previous window
let g:netrw_liststyle=3                         " set explorer to be tree style
let g:netrw_winsize=30                     " set explorer window width to be 30

if has('mouse')
  set mouse=a
endif
"}}}

"****************************************************************** Encoding{{{
if has('multi_byte')
  set encoding=utf-8
  set fileencodings=utf-8,gbk,gb2312,gb18030
  setglobal fileencoding=utf-8
endif
"}}}

"******************************************************************* General{{{
set autoindent                                           " set auto indentation
set backspace=indent,start                       " for vim-latex, see issue #53
set backup
set backupdir=$VIMCONFIG/recovery/backup
set colorcolumn=80                                          " show right margin
set cursorline                                          " highlight current row
set expandtab shiftwidth=2 softtabstop=2     " set <Tab> width to be 2 <space>s
set fillchars=vert:\|
set guicursor+=a:blinkon0-Cursor/lCursor
set tabstop=2                                " make real <Tab> to be width of 2
set hlsearch
set iminsert=0 imsearch=0                                " make IME more usable
set foldmethod=indent                      " fold code according to indentation
set foldlevelstart=99                              " start with no folds closed
set incsearch                                              " incremental search
set laststatus=2                           " show statusline even only 1 window
set linespace=0                                         " set line spacing to 0
set noshowmode
set number                                                   " show line number
" set relativenumber                                       " relative line number
set sessionoptions-=folds                 " do not create folds when sessioning
set showcmd                                                 " show pressed keys
set signcolumn=yes
set splitright                                            " split on right side
set splitbelow                                                 " split on below
set wildmenu                                 " show possible matches when <Tab>
set wildignorecase
set tags+=../tags
"}}}
