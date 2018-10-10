scriptencoding utf-8

augroup comment_format
    au!
    autocmd FileType * set fo-=ro       " turn off insertion of comment leaders
    autocmd FileType * set fo+=j   " remove a comment leader when joining lines
augroup END

augroup file_types
    au BufRead,BufNewFile *.jl setf julia
    au BufRead,BufNewFile *.nim setf nim
    au BufRead,BufNewFile *.note setf note
    au BufRead,BufNewFile *.tut setf tut
    au BufRead,BufNewFile *.oct setf octave
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
    autocmd BufUnload * call neur1n#statusline#UpdateOnce()
    autocmd CursorMoved,SessionLoadPost * call neur1n#statusline#UpdateColor()
augroup END

augroup templates
    au!
    autocmd BufNewFile *.* silent!
        \ execute '0r $VIMCONFIG/templates/skeleton.'.expand("<afile>:e")
augroup END
