scriptencoding utf-8

call plug#begin('$VIMCONFIG/plugged')
"********************************************************************** Misc{{{
Plug 'cohama/lexima.vim'
Plug 'liuchengxu/vista.vim'
Plug 'luochen1990/rainbow'
Plug 'matze/vim-move'
Plug 'mhinz/vim-startify'
Plug 'mileszs/ack.vim'
" Plug 'sheerun/vim-polyglot'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'triglav/vim-visual-increment'
Plug 'wesQ3/vim-windowswap'
Plug 'Yggdroot/LeaderF'
"}}}
"*********************************************************** Auto-completion{{{
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'Shougo/neco-vim', {'for': ['vim']}
Plug 'neoclide/coc-neco', {'for': ['vim']}
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"}}}
"******************************************************************* The End{{{
Plug 'Neur1n/neuims', {'on': 'IMSToggle'}
Plug 'Neur1n/neuline'
"}}}
call plug#end()
