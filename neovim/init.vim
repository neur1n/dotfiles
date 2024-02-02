scriptencoding utf-8

set nocompatible
set fileformat=unix
set fileformats=unix,dos

let $LANG='en'                                           " set message language
set langmenu=en                                             " set menu language

if has('mouse')
  set mouse=a
endif

if has('multi_byte')
  set encoding=utf-8
  set fileencodings=utf-8,gbk,gb2312,gb18030
  setglobal fileencoding=utf-8
endif

set autoindent                       " use indent of previous line on new lines
set backspace=indent,start
set backup
set colorcolumn=80
set cursorline
set expandtab shiftwidth=2 softtabstop=2   " insert 2 <Space>s instead of <Tab>
set foldmethod=marker
set foldlevelstart=99                              " start with no folds closed
set formatoptions-=ro                   " turn off insertion of comment leaders
set formatoptions+=j               " remove a comment leader when joining lines
set guicursor+=a:blinkon0-Cursor/lCursor
set hlsearch
set iminsert=0 imsearch=0
set incsearch
set laststatus=2                           " show statusline even only 1 window
set linespace=0
set list
set listchars=tab:⇥\ ,trail:·,nbsp:␣,extends:»,precedes:«
set modeline
set mousemodel=popup
set noshowmode
set number
set sessionoptions-=folds                 " do not create folds when sessioning
set showcmd                                                 " show pressed keys
set signcolumn=yes
set splitright                                            " split on right side
set splitbelow                                                 " split on below
set tabstop=2                                " make real <Tab> to be width of 2
set termguicolors
set wildmenu                                " show possible matches using <Tab>
set wildignorecase

set pumblend=20
set winblend=20

let mapleader = "-"                                   " set <Leader> to <minus>
let maplocalleader = "-"

"******************************************************************* Modules{{{
let $VIMCONF = stdpath('config')

for s:file in glob('$VIMCONF/viml/*.vim', v:false, v:true)
  execute 'source ' . s:file
endfor
" Modules}}}
