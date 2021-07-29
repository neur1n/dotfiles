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

nmap <leader>fc <Plug>(coc-fix-current)
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rf <Plug>(coc-refactor)
nmap <leader>rn <Plug>(coc-rename)

nmap <leader>fh <Plug>(coc-float-hide)
nmap <leader>fj <Plug>(coc-float-jump)

imap <C-s> <Plug>(coc-snippets-expand)
nmap <C-p> <Plug>(coc-diagnostic-prev)
nmap <C-n> <Plug>(coc-diagnostic-next)

nmap <silent> <C-c> <Plug>(coc-cursors-position)
nmap <silent> <C-d> <Plug>(coc-cursors-word)
xmap <silent> <C-d> <Plug>(coc-cursors-range)

vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

if get(g:, 'colors_name', '') ==# 'neuclr'
  highlight link CocInfoSign NeuGreen
  highlight link CocHintSign NeuBlue
  highlight link CocWarningSign NeuOrange
  highlight link CocErrorSign NeuRed
endif

let g:coc_global_extensions = [
      \ 'coc-diagnostic', 'coc-git', 'coc-json', 'coc-snippets',
      \ 'coc-spell-checker', 'coc-word']

"********************************************************** lsp highlighting{{{
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

"***************************************************** iamcco/coc-diagnostic{{{
call coc#config('diagnostic-languageserver.filetypes', {'html': 'tidy', 'vim': 'vint'})
"}}}
"********************************************************** neoclide/coc-git{{{
call coc#config('git.branchCharacter', '')
"}}}
"********************************************* coc-extensions/coc-powershell{{{
call coc#config('powershell.powerShellExePath', 'pwsh')
call coc#config('powershell.integratedConsole.showOnStartup', v:false)
"}}}
"***************************************************** neoclide/coc-snippets{{{
call coc#config('snippets.ultisnips.enable', v:true)
call coc#config('snippets.userSnippetsDirectory', $VIMCONFIG.'/configs/plugconf/coc-snippets')
"}}}
"************************************************** iamcco/coc-spell-checker{{{
call coc#config('cSpell.enabledLanguageIds', ['html', 'latex', 'markdown', 'plaintext', 'text'])
"}}}
"**************************************************** fannheyward/coc-texlab{{{
call coc#config('texlab.auxDirectory', 'aux')
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

if has('unix')
  call coc#config('texlab.forwardSearch.executable', 'okular')
  call coc#config('texlab.forwardSearch.args', ['--unique', 'file:%p#src:%l%f'])
elseif has('win32')
  call coc#config('texlab.forwardSearch.executable', 'SumatraPDF')
  call coc#config('texlab.forwardSearch.args', ['-reuse-instance', '%p', '-forward-search', '%f', '%l'])
endif

nnoremap <silent> <leader>ll :execute 'CocCommand texlab.Build'<CR>
nnoremap <silent> <leader>lv :execute 'CocCommand texlab.ForwardSearch'<CR>
"}}}
"}}}
