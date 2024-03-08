scriptencoding utf-8

let s:plugins = [
      "\ FIRST
      "\ {'author': 'dstein64'       , 'repo': 'vim-startuptime'      , 'opt': {}},
      "\ GENERAL
      \ {'author': 'skywind3000'    , 'repo': 'asyncrun.vim'         , 'opt': {}},
      \ {'author': 'skywind3000'    , 'repo': 'asynctasks.vim'       , 'opt': {}},
      \ {'author': 'github'         , 'repo': 'copilot.vim'          , 'opt': {}},
      \ {'author': 'tpope'          , 'repo': 'vim-commentary'       , 'opt': {}},
      \ {'author': 'ggandor'        , 'repo': 'leap.nvim'            , 'opt': {}},
      \ {'author': 'LhKipp'         , 'repo': 'nvim-nu'              , 'opt': {}},
      \ {'author': 'kylechui'       , 'repo': 'nvim-surround'        , 'opt': {}},
      \ {'author': 'nvim-treesitter', 'repo': 'nvim-treesitter'      , 'opt': {'do': ':TSUpdate'}},
      \ {'author': 'nguyenvukhang'  , 'repo': 'nvim-toggler'         , 'opt': {}},
      \ {'author': 'nvim-lua'       , 'repo': 'plenary.nvim'         , 'opt': {}},
      \ {'author': 'junegunn'       , 'repo': 'vim-easy-align'       , 'opt': {}},
      \ {'author': 'lukas-reineke'  , 'repo': 'indent-blankline.nvim', 'opt': {}},
      \ {'author': 'matze'          , 'repo': 'vim-move'             , 'opt': {}},
      \ {'author': 'mg979'          , 'repo': 'vim-visual-multi'     , 'opt': {}},
      \ {'author': 'wesQ3'          , 'repo': 'vim-windowswap'       , 'opt': {}},
      \ {'author': 'folke'          , 'repo': 'zen-mode.nvim'        , 'opt': {}},
      "\ COMPLETION
      \ {'author': 'neoclide'       , 'repo': 'coc.nvim'             , 'opt': {'branch': 'release'}},
      \ {'author': 'neoclide'       , 'repo': 'coc-neco'             , 'opt': {'for': 'vim'}},
      \ {'author': 'Shougo'         , 'repo': 'neco-vim'             , 'opt': {'for': 'vim'}},
      "\ LAST
      \ {'author': 'Neur1n'         , 'repo': 'neuims'               , 'opt': {'on': 'IMSToggle'}},
      \ {'author': 'Neur1n'         , 'repo': 'noline.nvim'          , 'opt': {}},
    \ ]

call plug#begin('$VIMCONF/plugged')
for p in s:plugins
  if empty(p.opt)
    Plug p.author . '/' . p.repo
  else
    Plug p.author . '/' . p.repo, p.opt
  endif
endfor
call plug#end()

for p in s:plugins
  if isdirectory($VIMCONF . '/plugged/' . p.repo)
    let s:file = $VIMCONF . '/viml/plugconf/' . p.repo . '.vim'

    if filereadable(s:file)
      execute 'source ' . s:file
    endif
  endif
endfor
