augroup CommentFormat
    au!
    autocmd FileType * set fo-=ro       " turn off insertion of comment leaders
    autocmd FileType * set fo+=j   " remove a comment leader when joining lines
augroup END

augroup FileTypes
    au BufRead,BufNewFile *.nim setf nim
    au BufRead,BufNewFile *.note setf note
    au BufRead,BufNewFile *.tut setf tut
    au BufRead,BufNewFile *.oct setf octave
augroup END

augroup PWD
    au!
    au BufEnter * silent! lcd %:p:h                            " auto cd to pwd
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
augroup END

augroup ScrollOff
    au!
    au BufEnter,WinEnter,WinNew,VimResized *,*.*
        \ let &scrolloff=winheight(win_getid())/3
augroup END

augroup Templates
    au!
    autocmd BufNewFile *.* silent!
        \ execute '0r $VIMCONFIG/templates/skeleton.'.expand("<afile>:e")
augroup END
