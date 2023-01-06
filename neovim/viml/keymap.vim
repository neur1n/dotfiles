scriptencoding utf-8

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
"}}}

"******************************************************************* Editing{{{
"           Insert a new line without entering insert mode (shift-enter, enter)
nnoremap <expr> <CR> &buftype ==# 'quickfix' ? '<CR>' : 'o<Esc>'
nnoremap <expr> <S-CR> &buftype ==# 'quickfix' ? '<S-CR>' : 'O<Esc>'
"}}}
