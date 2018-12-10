set nocompatible
set fileformat=unix    " The following two make Vim create unix file by default
set fileformats=unix,dos

if has('win32')
  let $VIMCONFIG=$HOME.'/AppData/Local/nvim'
  let g:python3_host_prog='E:/ProgramFiles/Python3/python'
else
  let $VIMCONFIG=$HOME.'/.config/nvim'
  let g:python3_host_prog='/usr/bin/python3'
endif

" let g:python_host_skip_check=1
" let g:loaded_python3_provider=1

"******************************************* {The Common Part of Vim and Neovim
exec 'source $VIMCONFIG/configs/common.vim'
" }

"************************************************************************** {UI
let $LANG='en'                                           " set message language
set langmenu=en                                             " set menu language
let g:netrw_winsize=15                     " set explorer window width to be 30
let g:netrw_liststyle=3                         " set explorer to be tree style

if has('mouse')
  set mouse=a
endif

" if has('syntax')
"   syntax on
"   set t_Co=256
"   set background=dark
"   if has('gui_running')
"     colorscheme solarized
"     let g:solarized_contrast='low'
"   else
"     colorscheme molokai
"   endif
" endif

if has('syntax')
  syntax on
  set t_Co=256
  set background=dark
  colorscheme gruvbox
  " colorscheme solarized
endif
" }

"************************************************************* {Moduled Configs
exec 'source $VIMCONFIG/configs/autocmd.vim'
" }
