scriptencoding utf-8

function! neutil#buf#DeleteHidden() abort
  let l:tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(l:tpbl, tabpagebuflist(v:val))')
  for l:buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(l:tpbl, v:val)==-1')
    silent! execute 'bwipeout '.l:buf
  endfor
endfunction

function! neutil#buf#ToggleReadOnly() abort
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

let s:root_patterns = ['.git', '.hg', '.root', '.svn', 'package.json']
function! neutil#buf#RootDirectory() abort
  let l:matcher = {}

  function! l:matcher.has(path, pattern) abort
    return !empty(globpath(escape(a:path, '?*[]'), a:pattern, v:true))
  endfunction

  function! l:matcher.is(path, pattern) abort
    return fnamemodify(a:path, ':t') ==# a:pattern
  endfunction

  function! l:matcher.sub(path, pattern) abort
    let l:parent = fnamemodify(a:path, ':h')

    while v:true
      let l:current = fnamemodify(l:parent, ':t')
      if l:current ==# a:pattern | return v:true | endif

      let [l:current, l:parent] = [l:parent, fnamemodify(l:parent, ':h')]
      if l:current ==# l:parent | break | endif
    endwhile

    return v:false
  endfunction

  let l:cwd = getcwd()

  while v:true
    for l:pattern in s:root_patterns
      if l:matcher.is(l:cwd, l:pattern)
        return fnamemodify(l:cwd, ':h')
      endif

      if l:matcher.has(l:cwd, l:pattern)
        return l:cwd
      endif

      if l:matcher.sub(l:cwd, l:pattern)
        return fnamemodify(l:cwd, ':h')
      endif
    endfor

    let [l:current, l:cwd] = [l:cwd, fnamemodify(l:cwd, ':h')]
    if l:current ==# l:cwd | break | endif
  endwhile

  return getcwd()
endfunction

function! neutil#buf#ToggleRelativeLineNumber() abort
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunction

function! neutil#buf#TrimTrailingWhitespace() abort
  silent! execute '%s/\s\+$//g'
endfunction

function! neutil#buf#TabToSpace() abort
  silent! execute '%s/\t/  /g'
endfunction
