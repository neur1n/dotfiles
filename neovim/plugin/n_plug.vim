scriptencoding utf-8

finish

if exists('g:loaded_n_plug')
  finish
endif

let g:loaded_n_plug = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

call plug#begin('$VIMCONF/plugged')
"********************************************************************* First{{{
Plug 'Neur1n/neucs.vim'
"}}}
"********************************************************************** Misc{{{
Plug 'cohama/lexima.vim'
"Plug 'dstein64/vim-startuptime'
Plug 'justinmk/vim-sneak'
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
Plug 'Shougo/neco-vim', {'for': ['vim']}
Plug 'neoclide/coc-neco', {'for': ['vim']}
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"}}}
"********************************************************************** Last{{{
Plug 'Neur1n/neuims', {'on': 'IMSToggle'}
Plug 'Neur1n/noline.nvim'
"}}}
" filetype off
call plug#end()
" filetype plugin syntax on

let &cpoptions = s:save_cpo
unlet s:save_cpo