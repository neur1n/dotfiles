scriptencoding utf-8

"************************************************** skywind3000/asyncrun.vim{{{
nnoremap <leader>ab :call <sid>BuildRule()<cr>
nnoremap <leader>ar :call <sid>RunRule()<cr>
nnoremap <leader>as :AsyncStop<cr>

let g:asyncrun_save = 2

let s:build_rule_map = {
      \ 'typescript': 's:BuildTypeScript',
      \ }

let s:run_rule_map = {
      \ 'html': 's:RunMarkdown',
      \ 'markdown': 's:RunMarkdown',
      \ 'python': 's:RunPython',
      \ 'typescript': 's:RunTypeScript',
      \ }

"------------------------------------------------------------- Build rules
function! s:BuildRule() abort
  if filereadable(asyncrun#get_root('%').'/makefile')
    execute 'AsyncRun -raw -cwd=<root> make'
  else
    if !empty(get(s:build_rule_map, &filetype, ''))
      call s:DefaultBuildRule()
    endif
  endif
endfunction

function! s:DefaultBuildRule() abort
  let l:Func = function(s:build_rule_map[&filetype])
  call l:Func()
endfunction

function! s:BuildTypeScript() abort
  execute 'AsyncRun npm run build'
endfunction

"--------------------------------------------------------------- Run rules
function! s:RunRule() abort
  if filereadable(asyncrun#get_root('%').'/makefile')
    execute 'AsyncRun -raw -cwd=<root> make'
  else
    if !empty(get(s:run_rule_map, &filetype, ''))
      call s:DefaultRunRule()
    endif
  endif
endfunction

function! s:DefaultRunRule() abort
  let l:Func = function(s:run_rule_map[&filetype])
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

function! s:RunTypeScript() abort
  execute 'AsyncRun npm run tsc'
endfunction
"}}}
