scriptencoding utf-8

"************************************************** skywind3000/asyncrun.vim{{{
nnoremap <leader>ar :call <sid>RunRule()<cr>
nnoremap <leader>as :AsyncStop<cr>

let g:asyncrun_save = 2

let s:rule_map = {
      \ 'markdown': 's:RunMarkdown',
      \ 'python': 's:RunPython',
      \ }

function! s:RunRule() abort
  if filereadable(asyncrun#get_root('%').'/makefile')
    execute 'AsyncRun -raw -cwd=<root> make'
  else
    if !empty(get(s:rule_map, &filetype, ''))
      call s:DefaultRule()
    endif
  endif
endfunction

function! s:DefaultRule() abort
  let l:Func = function(s:rule_map[&filetype])
  call l:Func()
endfunction

function! s:RunMarkdown() abort
  execute 'AsyncRun vivaldi % &'
endfunction

function! s:RunPython() abort
  if has('unix')
    execute 'AsyncRun -raw python3 -u %'
  elseif has('win32')
    execute 'AsyncRun -raw python -u %'
  endif
endfunction
"}}}
