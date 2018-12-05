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

function! SelectTemplate(mode)
    if a:mode ==# 'ex'  " Choose by extension
        execute ':silent! 0r $VIMCONFIG/templates/skeleton.'.expand('<afile>:e')
    elseif a:mode ==# 'ft'  " Choose by file type
        execute ':silent! 0r $VIMCONFIG/templates/skeleton.'.eval('&filetype')
    endif
endfunction

augroup templates
    au!
    autocmd BufNewFile *.* if count(['cmake'], &filetype)
                \ |     call SelectTemplate('ft')
                \ | else
                \ |     call SelectTemplate('ex')
                \ | endif
augroup END

augroup post
    au!
    autocmd VimEnter * execute 'source $VIMCONFIG/configs/colorscheme.vim'
augroup END
