call plug#begin('E:\ProgramFiles\Vim\vimfiles\plugged')
Plug 'honza/vim-snippets'
Plug 'lervag/vimtex'
Plug 'luochen1990/rainbow'
Plug 'majutsushi/tagbar', {'on': 'TagbarOpenAutoClose'}
Plug 'matze/vim-move'
Plug 'mhinz/vim-startify'
Plug 'nathanaelkane/vim-indent-guides', {'for': ['c', 'cpp', 'python']}
Plug 'roxma/vim-hug-neovim-rpc'
" Plug 'roxma/nvim-completion-manager'
Plug 'ikalnytskyi/nvim-completion-manager', {'branch': 'use-user_data-for-extra'}
Plug 'roxma/ncm-clang', {'for': ['c', 'cpp']}
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'triglav/vim-visual-increment'
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'
Plug 'wesQ3/vim-windowswap'
Plug 'will133/vim-dirdiff', {'on': 'DirDiff'}
" ------------------------------------------------ Load vim-devicons at the end
Plug 'ryanoasis/vim-devicons'
call plug#end()
