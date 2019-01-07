"                                               Replace <leader> key to <space>
let mapleader = ' '
let maplocalleader = ' '

"******************************************************************* General{{{
map Q <nop>
"           Remap F1 to esc, also need to disable F1 of gnome terminal manually
map <F1> <Esc>
imap <F1> <Esc>
"                                                     Split open tag definition
nnoremap <A-]> :vsp <cr>:exec("tag ".expand("<cword>"))<cr>
"}}}

"*************************************************************** Move Around{{{
"                         Go to a line and make it one the center of the screen
nnoremap G Gzz
"                                   Modify the behavior of j & k in normal mode
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
"                                                Move over panes in normal mode
nnoremap <A-Left> <C-w>h
nnoremap <A-Right> <C-w>l
nnoremap <A-Down> <C-w>j
nnoremap <A-Up> <C-w>k
"                                                    Move cursor in insert mode
inoremap <A-h> <Left>
inoremap <A-l> <Right>
inoremap <A-j> <Down>
inoremap <A-k> <Up>
"}}}

"******************************************************************* Editing{{{
"           Insert a new line without entering insert mode (shift-enter, enter)
nnoremap <cr> o<Esc>
nnoremap <S-cr> O<Esc>
"                                              Toggle current line highlighting
nnoremap <leader>cl :set cursorline! nocursorline?<cr>
"                                                    Toggle search highlighting
nnoremap <leader>hs :set hlsearch! hlsearch?<cr>
"                                                             Toggle spellcheck
nnoremap <leader>sc :set spell! spelllang=en_us<cr>
"                                                         Delete hidden buffers
nnoremap <leader>db :call neur1n#general#DelHiddenBuf()<cr>
"                                                              Toggle read only
nnoremap <leader>ro :call neur1n#general#ToggleReadOnly()<cr>
"                                                   Toggle relative line number
nnoremap <leader>rn :call neur1n#general#ToggleRelLnr()<cr>
"}}}

"************************************************************** Run or Build{{{
"                                                                      C or C++
nnoremap <leader>bc :wa<cr>:call neur1n#general#BuildC()<cr>
nnoremap <leader>rc :wa<cr>:call neur1n#general#RunC()<cr>
"                                                                            Go
nnoremap <leader>go :wa<cr>:call neur1n#general#RunGo()<cr>
"                                                                         Julia
nnoremap <leader>jl :wa<cr>:call neur1n#general#RunJulia()<cr>
"                                                                          Keil
nnoremap <leader>kb :call neur1n#general#RunKeil('-b ')<cr>
nnoremap <leader>kr :call neur1n#general#RunKeil('-cr ')<cr>
nnoremap <leader>kf :call neur1n#general#RunKeil('-f ')<cr>
nnoremap <leader>kd :call neur1n#general#RunKeil('-d ')<cr>
"                                                                             R
nnoremap <leader>rs :wa<cr>:call neur1n#general#RunRScript()<cr>
"}}}
