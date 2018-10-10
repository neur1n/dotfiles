call plug#begin('$VIMCONFIG/plugged')
Plug 'cohama/lexima.vim'
" Plug 'ctrlpvim/ctrlp.vim', {'on': 'CtrlP'}
" Plug 'iamcco/markdown-preview.vim', {'for': 'markdown'}
" Plug 'lervag/vimtex' " , {'for': ['tex']}
Plug 'luochen1990/rainbow'
Plug 'majutsushi/tagbar' " {'on': 'TagbarOpenAutoClose'}
Plug 'matze/vim-move'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'triglav/vim-visual-increment'
Plug 'w0rp/ale'
Plug 'wesQ3/vim-windowswap'
" Plug 'will133/vim-dirdiff', {'on': 'DirDiff'}
" Plug 'nathanaelkane/vim-indent-guides', {'for': ['c', 'cpp', 'python']}
" ----------------------------------------------------------------------- NCM 2
" Plug 'roxma/nvim-yarp'
" Plug 'autozimu/LanguageClient-neovim', {'branch': 'next'}
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'Shougo/neco-vim'
Plug 'honza/vim-snippets', {'for': ['go', 'python', 'tex', 'vim']}
Plug 'SirVer/ultisnips', {'for': ['go', 'python', 'tex', 'vim']}
" Plug 'ncm2/ncm2'
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-go', {'for': 'go'}
" Plug 'ncm2/ncm2-jedi', {'for': 'python'}
" Plug 'ncm2/ncm2-path'
" Plug 'ncm2/ncm2-tagprefix'
" Plug 'ncm2/ncm2-ultisnips', {'for': ['go', 'python', 'tex', 'vim']}
" Plug 'ncm2/ncm2-vim'
" ------------------------------------------------------------- Load at the end
Plug 'itchyny/vim-gitbranch'
Plug 'morhetz/gruvbox'
" Plug 'Neur1n/solarized_flood'
" Plug 'vim-airline/vim-airline'
call plug#end()
