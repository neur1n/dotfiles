scriptencoding utf-8

"****************************************************************** AutoCMDs{{{
augroup cd_pwd
  autocmd!
  autocmd BufEnter * silent! lcd %:p:h                         " auto cd to pwd
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \| execute "normal! g'\"" | endif
augroup END

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

augroup scroll_off
  autocmd!
  autocmd BufEnter,BufWinLeave,WinEnter,WinNew,VimResized *,*.*
        \ let &scrolloff=winheight(win_getid())/3
augroup END

augroup templates
  autocmd!
  autocmd BufNewFile *.* if count(['cmake'], &filetype)
        \|   call s:SelectTemplate('ft')
        \| else
        \|   call s:SelectTemplate('ex')
        \| endif
augroup END

augroup neuclr
  autocmd!
  autocmd FileType * call neuclr#neuclr#Highlight()
augroup END
"}}}

"***************************************************************** Functions{{{
function! s:SelectTemplate(mode) abort
  if a:mode ==# 'ex'  " Choose by extension
    silent! execute 'keepalt 0r $VIMCONFIG/templates/skeleton.'.expand('<afile>:e')
  elseif a:mode ==# 'ft'  " Choose by file type
    silent! execute 'keepalt 0r $VIMCONFIG/templates/skeleton.'.eval('&filetype')
  endif
endfunction
"}}}
