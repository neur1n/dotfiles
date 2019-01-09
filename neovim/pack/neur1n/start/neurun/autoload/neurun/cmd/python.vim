scriptencoding utf-8

function! neurun#cmd#python#Run() abort
  if filereadable('MAINFILE')  " Workspace
    let l:main = readfile('MAINFILE')[0]
  " elseif get(g:, 'neurun.python.main', '') !=# ''  " Global
  "   let l:main = g:runner.python.main
  else  " Current buffer
    let l:main = bufname('%')
  endif

  if has('unix')
    let l:python = 'python3'
  elseif has('win32')
    let l:python = 'python'
  endif

  return [l:python, '-u', l:main]
endfunction
