"                                               Replace <leader> key to <space>
let mapleader = ' '
let maplocalleader = ' '

" *****************************************************************************
"                                                                       General
" *****************************************************************************
map Q <nop>
"           Remap F1 to esc, also need to disable F1 of gnome terminal manually
map <F1> <Esc>
imap <F1> <Esc>
"                                                     Split open tag definition
nnoremap <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" *****************************************************************************
"                                                                   Move Around
" *****************************************************************************
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

" *****************************************************************************
"                                                                       Editing
" *****************************************************************************
"           Insert a new line without entering insert mode (shift-enter, enter)
nnoremap <CR> o<Esc>
nnoremap <S-CR> O<Esc>
"                                              Toggle current line highlighting
nnoremap <leader>cl :set cursorline! nocursorline?<CR>
"                                                    Toggle search highlighting
nnoremap <leader>hs :set hlsearch! hlsearch?<CR>
"                                                             Toggle spellcheck
nnoremap <leader>sc :set spell! spelllang=en_us<CR>
"                                                         Delete hidden buffers
nnoremap <leader>db :call neur1n#general#DelHiddenBuf()<CR>
"                                                              Toggle read only
nnoremap <leader>ro :call neur1n#general#ToggleReadOnly()<CR>
"                                                   Toggle relative line number
nnoremap <leader>rn :call neur1n#general#ToggleRelLnr()<CR>

" *****************************************************************************
"                                                                  Run or Build
" *****************************************************************************
"                                                                      C or C++
nnoremap <leader>bc :wa<CR>:call neur1n#general#BuildC()<CR>
nnoremap <leader>rc :wa<CR>:call neur1n#general#RunC()<CR>
"                                                                            Go
nnoremap <leader>go :wa<CR>:call neur1n#general#RunGo()<CR>
"                                                                         Julia
nnoremap <leader>jl :wa<CR>:call neur1n#general#RunJulia()<CR>
"                                                                          Keil
nnoremap <leader>kb :call neur1n#general#RunKeil('-b ')<CR>
nnoremap <leader>kr :call neur1n#general#RunKeil('-cr ')<CR>
nnoremap <leader>kf :call neur1n#general#RunKeil('-f ')<CR>
nnoremap <leader>kd :call neur1n#general#RunKeil('-d ')<CR>
"                                                                      Markdown
nnoremap <leader>md :call neur1n#general#ViewMarkdown()<CR>
"                                                                        Python
nnoremap <leader>py :wa<CR>:call neur1n#general#RunPython()<CR>
"                                                                             R
nnoremap <leader>rs :wa<CR>:call neur1n#general#RunRScript()<CR>
