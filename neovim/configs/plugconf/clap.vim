scriptencoding utf-8

"******************************************************* liuchengxu/vim-clap{{{
nnoremap <Leader>cb :Clap buffers<CR>
nnoremap <Leader>ce :Clap filer<CR>
nnoremap <Leader>cf :Clap files<CR>
nnoremap <Leader>cr :Clap grep<CR>
nnoremap <Leader>cm :Clap grep2<CR>
nnoremap <Leader>cw :Clap grep ++query=<cword><CR>
nnoremap <Leader>ch :Clap history<CR>
nnoremap <Leader>ct :Clap tags<CR>

let g:clap_enable_debug = 1
let g:clap_layout = {'relative': 'editor'}
"}}}
