scriptencoding utf-8

if exists('g:loaded_n_asynctasks')
  finish
endif

let g:loaded_n_asynctasks = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

nnoremap <leader>as :AsyncStop<CR>
nnoremap <leader>pi :AsyncTask project-init<CR>
nnoremap <leader>pb :AsyncTask project-build<CR>
nnoremap <leader>pr :AsyncTask project-run<CR>
nnoremap <leader>fb :AsyncTask file-build<CR>
nnoremap <leader>fr :AsyncTask file-run<CR>

let g:asynctasks_extra_config = [$VIMCONF.'/plugin/asynctasks.ini']

let &cpoptions = s:save_cpo
unlet s:save_cpo
