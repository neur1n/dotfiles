scriptencoding utf-8

"************************************************ skywind3000/asynctasks.vim{{{
nnoremap <leader>as :AsyncStop<CR>
nnoremap <leader>pi :AsyncTask project-init<CR>
nnoremap <leader>pb :AsyncTask project-build<CR>
nnoremap <leader>pr :AsyncTask project-run<CR>
nnoremap <leader>fb :AsyncTask file-build<CR>
nnoremap <leader>fr :AsyncTask file-run<CR>

let g:asynctasks_extra_config = [$VIMCONFIG.'/configs/plugconf/asynctasks.ini']
"}}}
