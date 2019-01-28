call plug#begin('$VIMCONFIG/plugged')
"************************************************************* The Beginning{{{
Plug 'Neur1n/neutil'
Plug 'Neur1n/neuclr'
"}}}
"********************************************************************** Misc{{{
Plug 'cohama/lexima.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'luochen1990/rainbow'
Plug 'majutsushi/tagbar'
Plug 'matze/vim-move'
Plug 'mhinz/vim-startify'
Plug 'mileszs/ack.vim'
Plug 'neomake/neomake'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'triglav/vim-visual-increment'
Plug 'wesQ3/vim-windowswap'
Plug 'Yggdroot/LeaderF'
"}}}
"*********************************************************** Auto-completion{{{
Plug 'Shougo/neco-vim', {'for': ['vim']}
Plug 'neoclide/coc-neco', {'for': ['vim']}
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
" Plug 'neoclide/coc-jedi', {'do': 'yarn install'}
"}}}
"******************************************************************* The End{{{
Plug 'Neur1n/neurun'
Plug 'Neur1n/neuline'
"}}}
call plug#end()
