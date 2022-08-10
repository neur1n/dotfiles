scriptencoding utf-8

if exists('g:loaded_n_clap')
  finish
endif

let g:loaded_n_clap = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

nnoremap <Leader>cb :Clap buffers<CR>
nnoremap <Leader>cc :Clap commands<CR>
nnoremap <Leader>ce :Clap filer<CR>
nnoremap <Leader>cf :Clap files ++finder=fd --hidden --type f<CR>
nnoremap <Leader>cr :Clap grep<CR>
nnoremap <Leader>cm :Clap grep2<CR>
nnoremap <Leader>cw :Clap grep ++query=<cword><CR>
nnoremap <Leader>ch :Clap history<CR>
nnoremap <Leader>ct :Clap tags<CR>

let g:clap_enable_debug = 1
let g:clap_layout = {'relative': 'editor'}

let &cpoptions = s:save_cpo
unlet s:save_cpo
