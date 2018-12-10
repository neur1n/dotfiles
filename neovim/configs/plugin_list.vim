call plug#begin('$VIMCONFIG/plugged')
"******************************************************* {Load at the beginning
Plug 'itchyny/vim-gitbranch'
Plug 'morhetz/gruvbox'
" }
"************************************************************************ {Misc
if has('nvim')
  Plug 'equalsraf/neovim-gui-shim'
endif
Plug 'cohama/lexima.vim'
Plug 'luochen1990/rainbow'
Plug 'majutsushi/tagbar' " {'on': 'TagbarOpenAutoClose'}
Plug 'matze/vim-move'
Plug 'mhinz/vim-startify'
Plug 'mileszs/ack.vim'
Plug 'neomake/neomake'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'triglav/vim-visual-increment'
" Plug 'w0rp/ale'
Plug 'wesQ3/vim-windowswap'
Plug 'Yggdroot/LeaderF'
" }
"************************************************************* {Auto-completion
Plug 'Shougo/neco-vim', {'for': ['vim']}
Plug 'neoclide/coc-neco', {'for': ['vim']}
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
" }
"********************************************************************* {The End
Plug 'Neur1n/statusline.vim'
" }
call plug#end()
