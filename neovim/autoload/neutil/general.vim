scriptencoding utf-8

"******************************************************************* Editing{{{
"                                             Delete hidden buffers: <leader>db
function! neutil#general#DeleteHiddenBuffer() abort
  let l:tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(l:tpbl, tabpagebuflist(v:val))')
  for l:buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(l:tpbl, v:val)==-1')
    silent execute 'bdelet' l:buf
  endfor
endfunction
"                                                  Toggle read only: <leader>ro
function! neutil#general#ToggleReadOnly() abort
  if &readonly == 1
    setlocal noreadonly
    if has('conceal')
      setlocal conceallevel=2 concealcursor=i
    endif
  else
    setlocal readonly
    if has('conceal')
      setlocal conceallevel=2 concealcursor=cn
    endif
  endif
endfunction
"                                       Toggle relative line number: <leader>rn
function! neutil#general#ToggleRelativeLineNumber() abort
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunction
"                                        Trim trailing white spaces: <leader>tw
function! neutil#general#TrimTrailingWhiteSpace() abort
  execute '%s/\s\+$//gc'
endfunction
"                                      Replace hard tab with spaces: <leader>ts
function! neutil#general#ReplaceTabWithSpace() abort
  execute '%s/\t/  /gc'
endfunction
"}}}

" TODO: move to neurun
""************************************************************** Run or Build{{{
""                                                                      C or C++
"function! general#BuildC() abort
"  if filereadable('MAINFILE')
"    let l:file_id = readfile('MAINFILE')
"    if &filetype ==# 'cpp'
"      execute '!g++ '.l:file_id[0].' -o '.l:file_id[1]
"    elseif &filetype ==# 'c'
"      execute '!gcc '.l:file_id[0].' -o '.l:file_id[1]
"    endif
"  else
"    if &filetype ==# 'cpp'
"      execute '!g++ '.bufname('%').' -o '.expand('%:r').'.out'
"    elseif &filetype ==# 'c'
"      execute '!gcc '.bufname('%').' -o '.expand('%:r').'.out'
"    endif
"  endif
"endfunction

"function! general#RunC() abort
"  if filereadable('MAINFILE')
"    let l:file_id = readfile('MAINFILE')
"    execute '!./'.l:file_id[1]
"  else
"    execute '!./'.expand('%:r').'.out'
"  endif
"endfunction
""                                                                            Go
"function! general#RunGo() abort
"  if filereadable('MAINFILE')
"    let l:file_id = readfile('MAINFILE')
"    execute '!go run '.l:file_id[0]
"  else
"    execute '!go run %'
"  endif
"endfunction
""                                                                         Julia
"function! general#RunJulia() abort
"  execute '!julia %'
"endfunction
""                                                                          Keil
"function! general#RunKeil(options) abort
"  let l:target = ''

"  if !empty(glob('*.uvprojx'))
"    let l:target =  glob('*.uvprojx')
"  elseif !empty(glob('../../*.uvprojx'))
"    let l:target =  glob('../../*.uvprojx')
"  endif

"  if !empty(l:target)
"    execute 'wa'
"    execute ':silent !uv4 '.a:options.l:target.' -o "\%TEMP\%/log.txt"'
"    execute ':sp $TEMP/log.txt'
"    execute 'normal! Gzz'
"  else
"    echo 'Target not found!'
"  endif
"endfunction
""                                                                      Markdown
"function! general#ViewMarkdown() abort
"  if has('unix')
"    let l:browser = '/usr/bin/vivaldi'
"  elseif has('win32')
"    let l:browser = 'E:/ProgramFiles/Opera/launcher.exe'
"  endif

"  let l:html = expand('%:r').'.html'
"  if filereadable(l:html)
"    execute 'silent !'.l:browser.' '.l:html
"  else
"    execute 'silent !'.l:browser.' %'
"  endif
"endfunction
""                                                                             R
"function! general#RunRScript() abort
"  if filereadable('MAINFILE')
"    let l:file = readfile('MAINFILE')
"    execute '!Rscript '.l:file[0]
"  else
"    execute '!Rscript %'
"  endif
"endfunction
""}}}
