scriptencoding utf-8

augroup comment_format
  autocmd!
  autocmd FileType * set fo-=ro         " turn off insertion of comment leaders
  autocmd FileType * set fo+=j     " remove a comment leader when joining lines
augroup END

augroup file_types
  autocmd!
  autocmd BufNewFile,BufRead *.jl setf julia
  autocmd BufNewFile,BufRead *.material,*.partical,*.program setf ogrematerial
  autocmd BufNewFile,BufRead *.note setf note
  autocmd BufNewFile,BufRead *.launch,*.sdf,*.world setf xml
  autocmd BufNewFile,BufRead *.oct setf octave
augroup END

augroup cd_pwd
  autocmd!
  autocmd BufEnter * silent! lcd %:p:h                         " auto cd to pwd
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \| execute "normal! g'\"" | endif
augroup END

augroup scroll_off
  autocmd!
  autocmd BufEnter,WinEnter,WinNew,VimResized *,*.*
        \ let &scrolloff=winheight(win_getid())/3
augroup END

function! s:SelectTemplate(mode)
  if a:mode ==# 'ex'  " Choose by extension
    execute ':silent! 0r $VIMCONFIG/templates/skeleton.'.expand('<afile>:e')
  elseif a:mode ==# 'ft'  " Choose by file type
    execute ':silent! 0r $VIMCONFIG/templates/skeleton.'.eval('&filetype')
  endif
endfunction

augroup templates
  autocmd!
  autocmd BufNewFile *.* if count(['cmake'], &filetype)
        \|   call s:SelectTemplate('ft')
        \| else
        \|   call s:SelectTemplate('ex')
        \| endif
augroup END

" augroup post
"   au!
"   autocmd VimEnter * source $VIMCONFIG/configs/colorscheme.vim
" augroup END
