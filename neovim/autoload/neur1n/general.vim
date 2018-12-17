"********************************************************************* {Editing
"                                             Delete hidden buffers: <leader>db
function neur1n#general#DelHiddenBuf()
  let l:tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(l:tpbl, tabpagebuflist(v:val))')
  for l:buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(l:tpbl, v:val)==-1')
    silent execute 'bdelet' l:buf
  endfor
endfunction
"                                                  Toggle read only: <leader>ro
function neur1n#general#ToggleReadOnly()
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
"                                       Toggle relative line number: <leader>rn
function! neur1n#general#ToggleRelLnr()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunction
" }

"**************************************************************** {Run or Build
"                                                                      C or C++
function! neur1n#general#BuildC()
  if filereadable('MAINFILE')
    let l:file_id = readfile('MAINFILE')
    if &ft ==# 'cpp'
      execute '!g++ '.l:file_id[0].' -o '.l:file_id[1]
    elseif &ft ==# 'c'
      execute '!gcc '.l:file_id[0].' -o '.l:file_id[1]
    endif
  else
    if &ft ==# 'cpp'
      execute '!g++ '.bufname('%').' -o '.expand('%:r').'.out'
    elseif &ft ==# 'c'
      execute '!gcc '.bufname('%').' -o '.expand('%:r').'.out'
    endif
  endif
endfunction

function! neur1n#general#RunC()
  if filereadable('MAINFILE')
    let l:file_id = readfile('MAINFILE')
    execute '!./'.l:file_id[1]
  else
    execute '!./'.expand('%:r').'.out'
  endif
endfunction
"                                                                            Go
function! neur1n#general#RunGo()
  if filereadable('MAINFILE')
    let l:file_id = readfile('MAINFILE')
    execute '!go run '.l:file_id[0]
  else
    execute '!go run %'
  endif
endfunction
"                                                                         Julia
function! neur1n#general#RunJulia()
  execute '!julia %'
endfunction
"                                                                          Keil
function! neur1n#general#RunKeil(options)
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
"                                                                      Markdown
function! neur1n#general#ViewMarkdown()
  if has('unix')
    let l:browser = '/usr/bin/vivaldi'
  elseif has('win32')
    let l:browser = 'E:/ProgramFiles/Opera/launcher.exe'
  endif

  let l:html = expand('%:r').'.html'
  if filereadable(l:html)
    execute 'silent !'.l:browser.' '.l:html
  else
    execute 'silent !'.l:browser.' %'
  endif
endfunction
"                                                                        Python
function! neur1n#general#RunPython()
  if filereadable('MAINFILE')
    let l:file = readfile('MAINFILE')
    execute '!python3 '.l:file[0]
  else
    execute '!python3 %'
  endif
endfunction
"                                                                             R
function! neur1n#general#RunRScript()
  if filereadable('MAINFILE')
    let l:file = readfile('MAINFILE')
    execute '!Rscript '.l:file[0]
  else
    execute '!Rscript %'
  endif
endfunction
" }
