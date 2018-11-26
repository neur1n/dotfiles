call plug#begin('$VIMCONFIG/plugged')
"******************************************************** Load at the beginning
Plug 'itchyny/vim-gitbranch'
Plug 'morhetz/gruvbox'
"************************************************************************* Misc
Plug 'cohama/lexima.vim'
Plug 'equalsraf/neovim-gui-shim'
Plug 'luochen1990/rainbow'
Plug 'majutsushi/tagbar' " {'on': 'TagbarOpenAutoClose'}
Plug 'matze/vim-move'
Plug 'mhinz/vim-startify'
" Plug 'neomake/neomake'
" Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'triglav/vim-visual-increment'
Plug 'w0rp/ale'
Plug 'wesQ3/vim-windowswap'
"************************************************************** Auto-completion
Plug 'Shougo/neco-vim', {'for': ['vim']}
Plug 'honza/vim-snippets' ", {'for': ['c', 'cpp', 'go', 'python', 'tex', 'vim']}
Plug 'SirVer/ultisnips' ", {'for': ['c', 'cpp', 'go', 'python', 'tex', 'vim']}
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
"********************************************************************** The End
Plug 'Neur1n/statusline.vim'
call plug#end()
