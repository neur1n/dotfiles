"                                          Replace <leader> key to <space>
let mapleader = ' '

" *****************************************************************************
"                                                                       General
" *****************************************************************************
map Q <nop>

"      Remap F1 to esc, also need to disable F1 of gnome terminal manually
map <F1> <Esc>
imap <F1> <Esc>

" *****************************************************************************
"                                                                      Toggling
" *****************************************************************************
"                                         Toggle relative line number: \rn
function ToggleRelativeLineNumber()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunction
nnoremap <leader>rn :call ToggleRelativeLineNumber()<CR>

"                                                    Toggle read only: \ro
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

"                                    Toggle current line highlighting: \cl
nnoremap <leader>cl :set cursorline! nocursorline?<CR>

"                                          Toggle search highlighting: \hs
nnoremap <leader>hs :set hlsearch! hlsearch?<CR>

"                                                   Toggle spellcheck: \sc
nnoremap <leader>sc :set spell! spelllang=en_us<CR>

" *****************************************************************************
"                                                                   Move Around
" *****************************************************************************
"                    Go to a line and make it one the center of the screen
nnoremap G Gzz

"                              Modify the behavior of j & k in normal mode
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

"                                           Move over panes in normal mode
nnoremap <Left> <C-W>h
nnoremap <Right> <C-W>l
nnoremap <Down> <C-W>j
nnoremap <Up> <C-W>k

"                                               Move cursor in insert mode
inoremap <A-h> <Left>
inoremap <A-l> <Right>
inoremap <A-j> <Down>
inoremap <A-k> <Up>

" *****************************************************************************
"                                                                       Editing
" *****************************************************************************
"                                                    Delete hidden buffers
function DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction
nnoremap <leader>dh :call DeleteHiddenBuffers()<CR>

"      Insert a new line without entering insert mode (shift-enter, enter)
nnoremap <CR> o<Esc>
nnoremap <S-CR> O<Esc>

"                                  Automatically append closing characters
inoremap ( ()<Left>
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap [ []<Left>
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap { {}<Left>
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"

" *****************************************************************************
"                                                                      For Tags
" *****************************************************************************
"                                                    Split open definition
nnoremap <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>


" *****************************************************************************
"                                                                  Run or Build
" *****************************************************************************
"                                                        Run Python script
function RunPythonScript()
    "if filereadable("main.py")
    "    wa
    "    silent !python main.py
    if filereadable('MAINFILE')
        let l:file_id = readfile('MAINFILE')
        "silent !python $(file_id[0])
        execute 'wa'
        execute 'silent !python '.l:file_id[0]
    else
        "wa
        "silent !python %
        execute 'wa'
        execute 'silent !python %'
    endif
endfunction
nnoremap <leader>py :call RunPythonScript()<CR>
nnoremap <leader>pp :wa<CR>:!python %<CR>

"                                                            Keil commands
function MakeKeilTarget(options)
    let l:target = ''

    if !empty(glob('*.uvprojx'))
        let l:target =  glob('*.uvprojx')
    elseif !empty(glob('../../*.uvprojx'))
        let l:target =  glob('../../*.uvprojx')
    endif

    if !empty(l:target)
        execute ':silent !uv4 '.a:options.l:target.' -o "\%TEMP\%/log.txt"'
        execute ':sp $TEMP/log.txt'
        execute 'normal! Gzz'
    else
        echo 'Target not found!'
    endif
endfunction
nnoremap <leader>kb :call MakeKeilTarget('-b')<CR>
nnoremap <leader>kr :call MakeKeilTarget('-cr ')<CR>
nnoremap <leader>kf :call MakeKeilTarget('-f ')<CR>
nnoremap <leader>kd :call MakeKeilTarget('-d ')<CR>
