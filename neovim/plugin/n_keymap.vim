scriptencoding utf-8

if exists('g:loader_n_keymap')
  finish
endif

let g:loaded_n_keymap = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

"******************************************************************* General{{{
map Q <NOP>
"           remap F1 to esc, also need to disable F1 of gnome terminal manually
map <F1> <Esc>
imap <F1> <Esc>
"                                                         search selected texts
vnoremap // y/\V<C-R>=escape(@", '\/')<CR><CR>
"                                                            exit terminal mode
tnoremap <Esc> <C-\><C-n>
"}}}

"**************************************************************** Navigation{{{
"                         go to a line and make it one the center of the screen
nnoremap G Gzz
"                                   modify the behavior of j & k in normal mode
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
"                                                 traverse panes in normal mode
nnoremap <A-Left> <C-w>h
nnoremap <A-Right> <C-w>l
nnoremap <A-Down> <C-w>j
nnoremap <A-Up> <C-w>k
"}}}

"******************************************************************* Editing{{{
"           Insert a new line without entering insert mode (shift-enter, enter)
nnoremap <expr> <CR> &buftype ==# 'quickfix' ? '<CR>' : 'o<Esc>'
nnoremap <expr> <S-CR> &buftype ==# 'quickfix' ? '<S-CR>' : 'O<Esc>'
"                                                             Toggle spellcheck
nnoremap <Leader>sc :set spell! spelllang=en_us<CR>
"}}}

"***************************************************************** Interface{{{
function! s:ToggleStatusline() abort
  if &laststatus == 2
    set laststatus=3
  else
    set laststatus=2
  endif
endfunction

nnoremap <silent> <Leader>ls :call <SID>ToggleStatusline()<CR>
"}}}

let &cpoptions = s:save_cpo
unlet s:save_cpo
