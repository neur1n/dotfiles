scriptencoding utf-8

call plug#begin('$VIMCONFIG/plugged')
"********************************************************************* First{{{
Plug 'Neur1n/neucs.vim'
"}}}
"********************************************************************** Misc{{{
Plug 'cohama/lexima.vim'
Plug 'justinmk/vim-sneak'
Plug 'liuchengxu/vim-clap', {'do': {-> clap#installer#force_download()}}
Plug 'liuchengxu/vista.vim'
Plug 'luochen1990/rainbow'
Plug 'matze/vim-move'
Plug 'mg979/vim-visual-multi'
Plug 'mhinz/vim-startify'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'triglav/vim-visual-increment'
Plug 'wesQ3/vim-windowswap'
"}}}
"*********************************************************** Auto-completion{{{
Plug 'Shougo/neco-vim', {'for': ['vim']}
Plug 'neoclide/coc-neco', {'for': ['vim']}
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"}}}
"********************************************************************** Last{{{
Plug 'Neur1n/neuims', {'on': 'IMSToggle'}
Plug 'Neur1n/neuline'
"}}}
call plug#end()
