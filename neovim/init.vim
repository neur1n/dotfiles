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
set guicursor+=a:blinkon0-Cursor/lCursor
set hlsearch
set iminsert=0 imsearch=0
set incsearch
set laststatus=2                           " show statusline even only 1 window
set linespace=0
set noshowmode
set number
set sessionoptions-=folds                 " do not create folds when sessioning
set showcmd                                                 " show pressed keys
set signcolumn=yes
set splitright                                            " split on right side
set splitbelow                                                 " split on below
set tabstop=2                                " make real <Tab> to be width of 2
set wildmenu                                " show possible matches using <Tab>
set wildignorecase

set pumblend=20
set winblend=20

let mapleader = "-"                                   " set <Leader> to <minus>
let maplocalleader = "-"

let $VIMCONF = stdpath('config')

call plug#begin('$VIMCONF/plugged')
"********************************************************************** Misc{{{
Plug 'cohama/lexima.vim'
Plug 'dstein64/vim-startuptime'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug 'LhKipp/nvim-nu', {'do': ':TSInstall nu', 'for': 'nu'}
Plug 'liuchengxu/vim-clap', {'do': {-> clap#installer#force_download()}}
Plug 'liuchengxu/vista.vim'
Plug 'luochen1990/rainbow'
Plug 'matze/vim-move'
Plug 'mfussenegger/nvim-dap'
Plug 'mg979/vim-visual-multi'
Plug 'mhinz/vim-startify'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'rcarriga/nvim-dap-ui'
Plug 'rcarriga/nvim-notify'
Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/asynctasks.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'triglav/vim-visual-increment'
Plug 'wesQ3/vim-windowswap'
"}}}
"*********************************************************** Auto-completion{{{
Plug 'Shougo/neco-vim', {'for': 'vim'}
Plug 'neoclide/coc-neco', {'for': 'vim'}
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"}}}
"********************************************************************** Last{{{
Plug 'Neur1n/neuims', {'on': 'IMSToggle'}
Plug 'Neur1n/noline.nvim'
"}}}
call plug#end()
