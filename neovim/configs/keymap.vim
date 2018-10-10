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

" *****************************************************************************
"                                                                      Toggling
" *****************************************************************************
"                                              Toggle relative line number: \rn
function ToggleRelativeLineNumber()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunction
nnoremap <leader>rn :call ToggleRelativeLineNumber()<CR>

"                                                         Toggle read only: \ro
function ToggleReadOnly()
    if &readonly == 1
        setl noreadonly
        if has('conceal')
            setl conceallevel=2 cocu=i
        endif
    else
        setl readonly
        if has('conceal')
            setl conceallevel=2 cocu=cn
        endif
    endif
endfunction
nnoremap <leader>ro :call ToggleReadOnly()<CR>

"                                         Toggle current line highlighting: \cl
nnoremap <leader>cl :set cursorline! nocursorline?<CR>

"                                               Toggle search highlighting: \hs
nnoremap <leader>hs :set hlsearch! hlsearch?<CR>

"                                                        Toggle spellcheck: \sc
nnoremap <leader>sc :set spell! spelllang=en_us<CR>

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
nnoremap <Left> <C-W>h
nnoremap <Right> <C-W>l
nnoremap <Down> <C-W>j
nnoremap <Up> <C-W>k

"                                                    Move cursor in insert mode
inoremap <A-h> <Left>
inoremap <A-l> <Right>
inoremap <A-j> <Down>
inoremap <A-k> <Up>

" *****************************************************************************
"                                                                       Editing
" *****************************************************************************
"                                                         Delete hidden buffers
function DeleteHiddenBuffers()
    let l:tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(l:tpbl, tabpagebuflist(v:val))')
    for l:buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(l:tpbl, v:val)==-1')
        silent execute 'bwipeout' l:buf
    endfor
endfunction
nnoremap <leader>dh :call DeleteHiddenBuffers()<CR>

"      Insert a new line without entering insert mode (shift-enter, enter)
nnoremap <CR> o<Esc>
nnoremap <S-CR> O<Esc>

" *****************************************************************************
"                                                                      For Tags
" *****************************************************************************
"                                                         Split open definition
nnoremap <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" *****************************************************************************
"                                                                  Run or Build
" *****************************************************************************
"                                                                            Go
function RunGo()
    if filereadable('MAINFILE')
        let l:file_id = readfile('MAINFILE')
        execute '!go run '.l:file_id[0]
    else
        execute '!go run %'
    endif
endfunction
nnoremap <leader>go :wa<CR>:call RunGo()<CR>
"                                                                          Keil
function KeilCMD(options)
    let l:target = ''

    if !empty(glob('*.uvprojx'))
        let l:target =  glob('*.uvprojx')
    elseif !empty(glob('../../*.uvprojx'))
        let l:target =  glob('../../*.uvprojx')
    endif

    if !empty(l:target)
        execute 'wa'
        execute ':silent !uv4 '.a:options.l:target.' -o "\%TEMP\%/log.txt"'
        execute ':sp $TEMP/log.txt'
        execute 'normal! Gzz'
    else
        echo 'Target not found!'
    endif
endfunction
nnoremap <leader>kb :call KeilCMD('-b ')<CR>
nnoremap <leader>kr :call KeilCMD('-cr ')<CR>
nnoremap <leader>kf :call KeilCMD('-f ')<CR>
nnoremap <leader>kd :call KeilCMD('-d ')<CR>
"                                                                      Markdown
function ViewMarkdown()
    let l:browser = 'E:\ProgramFiles\Opera\launcher.exe'
    execute 'silent !'.l:browser.' %'
endfunction
nnoremap <leader>md :call ViewMarkdown()<CR>
"                                                                        Python
function RunPython()
    "if filereadable("main.py")
    "    wa
    "    silent !python main.py
    if filereadable('MAINFILE')
        let l:file_id = readfile('MAINFILE')
        execute '!python '.l:file_id[0]
    else
        "wa
        "silent !python %
        execute '!python %'
    endif
endfunction
nnoremap <leader>py :wa<CR>:call RunPython()<CR>
