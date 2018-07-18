if has('win32')
    let s:source_path = '~/AppData/Local/nvim'
else
    let s:source_path = $HOME
endif

call plug#begin(s:source_path.'/plugged')
Plug 'cohama/lexima.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'iamcco/markdown-preview.vim', {'for': 'markdown'}
Plug 'lervag/vimtex'
Plug 'luochen1990/rainbow'
Plug 'majutsushi/tagbar' " {'on': 'TagbarOpenAutoClose'}
Plug 'matze/vim-move'
Plug 'mhinz/vim-startify'
" Plug 'neomake/neomake'
Plug 'tpope/vim-surround'
Plug 'triglav/vim-visual-increment'
Plug 'w0rp/ale'
Plug 'wesQ3/vim-windowswap'
Plug 'will133/vim-dirdiff', {'on': 'DirDiff'}
" ----------------------------------------------------------------------- NCM 2
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-go'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-tagprefix'
Plug 'roxma/nvim-yarp'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
" ------------------------------------------------------------- Load at the end
Plug 'itchyny/vim-gitbranch'
Plug 'maximbaz/lightline-ale'
Plug 'maximbaz/lightline-trailing-whitespace'
Plug 'mgee/lightline-bufferline'
Plug 'mkalinski/vim-lightline_tagbar'
Plug 'Neur1n/solarized_flood'
Plug 'itchyny/lightline.vim'
call plug#end()
