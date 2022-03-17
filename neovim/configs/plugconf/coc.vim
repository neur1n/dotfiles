scriptencoding utf-8

"********************************************************* neoclide/coc.nvim{{{
set completeopt=menuone,noinsert,noselect

function! s:CheckBackSpace() abort
  let l:col = col('.') - 1
  return !l:col || getline('.')[l:col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" :
      \ <SID>CheckBackSpace() ? "\<Tab>" : coc#refresh()
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

nmap <silent> <leader>gD <Plug>(coc-declaration)
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>rf <Plug>(coc-refactor)
nmap <silent> <leader>rn <Plug>(coc-rename)

nmap <silent> <leader>fc <Plug>(coc-fix-current)
nmap <silent> <leader>fh <Plug>(coc-float-hide)
nmap <silent> <leader>fj <Plug>(coc-float-jump)

nmap <silent> <C-p> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-n> <Plug>(coc-diagnostic-next)
imap <silent> <C-s> <Plug>(coc-snippets-expand)

vmap <silent> <leader>a <Plug>(coc-codeaction-selected)
nmap <silent> <leader>a <Plug>(coc-codeaction-selected)

autocmd CursorHold * silent call CocActionAsync('highlight')

" if g:loaded_neucs
"   highlight! link CocInfoSign NeuGreen
"   highlight! link CocHintSign NeuBlue
"   highlight! link CocWarningSign NeuOrange
"   highlight! link CocErrorSign NeuRed
" endif

let g:coc_global_extensions = [
      \ 'coc-diagnostic', 'coc-git', 'coc-json', 'coc-snippets',
      \ 'coc-spell-checker', 'coc-word']

"---------------------------------------------------------- lsp highlighting{{{
" Ordered according to https://code.visualstudio.com/api/language-extensions/semantic-highlight-guide
highlight! link CocSem_namespace Identifier
highlight! link CocSem_class Structure
highlight! link CocSem_enum Type
highlight! link CocSem_interface Type
highlight! link CocSem_struct Structure
highlight! link CocSem_typeParameter Type
highlight! link CocSem_type Type

highlight! link CocSem_parameter Identifier
highlight! link CocSem_variable Identifier
highlight! link CocSem_property Identifier

highlight! link CocSem_enumConstant Constant
highlight! link CocSem_enumMember Constant
highlight! link CocSem_event Identifier

highlight! link CocSem_function Function
highlight! link CocSem_method Function

highlight! link CocSem_macro Macro

highlight! link CocSem_label Label

highlight! link CocSem_comment Comment

highlight! link CocSem_string String

highlight! link CocSem_keyword Keyword

highlight! link CocSem_number Number

highlight! link CocSem_regexp String

highlight! link CocSem_operator Operator
"}}}

"----------------------------------------------------- iamcco/coc-diagnostic{{{
call coc#config('diagnostic-languageserver.filetypes', {'html': 'tidy', 'vim': 'vint'})
"}}}
"-------------------------------------------------- iamcco/coc-spell-checker{{{
call coc#config('cSpell.allowCompoundWords', v:true)
"}}}
"---------------------------------------------------------- neoclide/coc-git{{{
call coc#config('git.branchCharacter', '')
"}}}
"---------------------------------------------------- neoclide/coc-highlight{{{
call coc#config('highlight.filetypes', ['*'])
"}}}
"--------------------------------------------- coc-extensions/coc-powershell{{{
call coc#config('powershell.powerShellExePath', 'pwsh')
call coc#config('powershell.integratedConsole.showOnStartup', v:false)
"}}}
"----------------------------------------------------- neoclide/coc-snippets{{{
call coc#config('snippets.ultisnips.enable', v:true)
call coc#config('snippets.userSnippetsDirectory', $VIMCONFIG.'/configs/plugconf/coc-snippets')
"}}}
"-------------------------------------------------- iamcco/coc-spell-checker{{{
call coc#config('cSpell.enabledLanguageIds', ['html', 'latex', 'markdown', 'plaintext', 'tex', 'text'])
"}}}
"------------------------------------------------- xiyaowong/coc-sumneko-lua{{{
call coc#config('sumneko-lua.enableNvimLuaDev', v:true)
"}}}
"---------------------------------------------------- fannheyward/coc-texlab{{{
call coc#config('texlab.auxDirectory', 'build')
call coc#config('texlab.build.onSave', v:true)
call coc#config('texlab.build.executable', 'xelatex')
call coc#config('texlab.build.args', [
      \ '-file-line-error',
      \ '-interaction=nonstopmode',
      \ '-output-directory=build',
      \ '-shell-escape',
      \ '-synctex=1',
      \ '%f'
      \ ])
call coc#config('texlab.path', 'texlab')

if has('unix')
  call coc#config('texlab.forwardSearch.executable', 'okular')
  call coc#config('texlab.forwardSearch.args', ['--unique', 'file:%p#src:%l%f'])
elseif has('win32')
  call coc#config('texlab.forwardSearch.executable', 'SumatraPDF')
  call coc#config('texlab.forwardSearch.args', ['-reuse-instance', '%p', '-forward-search', '%f', '%l'])
endif

nnoremap <silent> <leader>ll :execute 'CocCommand latex.Build'<CR>
nnoremap <silent> <leader>lv :execute 'CocCommand latex.ForwardSearch'<CR>
"}}}
"}}}
