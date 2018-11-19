scriptencoding utf-8

augroup comment_format
    au!
    autocmd FileType * set fo-=ro       " turn off insertion of comment leaders
    autocmd FileType * set fo+=j   " remove a comment leader when joining lines
augroup END

augroup file_types
    au!
    au BufNewFile,BufRead *.jl setf julia
    au BufNewFile,BufRead *.material,*.partical,*.program setf ogrematerial
    au BufNewFile,BufRead *.note setf note
    au BufNewFile,BufRead *.launch,*.sdf,*.world setf xml
    au BufNewFile,BufRead *.oct setf octave
augroup END

augroup cd_pwd
    au!
    au BufEnter * silent! lcd %:p:h                            " auto cd to pwd
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
augroup END

augroup scroll_off
    au!
    au BufEnter,WinEnter,WinNew,VimResized *,*.*
        \ let &scrolloff=winheight(win_getid())/3
augroup END

augroup status_line
    au!
    autocmd WinEnter,BufWinEnter,FileType,SessionLoadPost * call neur1n#statusline#Update()
    autocmd CursorMoved,BufUnload * call neur1n#statusline#UpdateOnce()
    autocmd SessionLoadPost * call neur1n#statusline#UpdateColor()
augroup END

function! SelectTemplate()
    if has('win32')
        execute ':silent! 0r $VIMCONFIG/templates/win/skeleton.'.expand("<afile>:e")
    elseif has('unix')
        execute ':silent! 0r $VIMCONFIG/templates/unix/skeleton.'.expand("<afile>:e")
    endif
endfunction

augroup templates
    au!
    autocmd BufNewFile *.* call SelectTemplate()
augroup END

augroup post
    au!
    autocmd VimEnter * execute 'source $VIMCONFIG/configs/colorscheme.vim'
augroup END