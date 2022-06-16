scriptencoding utf-8

if exists('g:loaded_n_env')
  finish
endif

let g:loaded_n_env = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

let g:is_mac = has('mac')
let g:is_unix = has('unix')
let g:is_win = has('win32')
let g:is_wsl = has('wsl')

let s:cwd = fnamemodify(resolve(expand('<sfile>')), ':p:h')

if g:is_mac
elseif g:is_unix || g:is_wsl
  let g:python3_host_prog = 'python3'
elseif g:is_win
  let g:python3_host_prog = 'python'

  let s:paths = globpath(s:cwd, '../../bin/*/win', 0, 1)
  let s:paths = join(s:paths, ';')
  let $PATH .= ';' . s:paths
endif

unlet s:cwd

set backupdir=$VIMCONF/recovery/backup

let &cpoptions = s:save_cpo
unlet s:save_cpo
