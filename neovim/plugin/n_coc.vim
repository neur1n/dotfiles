scriptencoding utf-8

if exists('g:loaded_n_coc')
  finish
endif

let g:loaded_n_coc = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

set completeopt=menuone,noinsert,noselect

function! s:CheckBackSpace() abort
  let l:col = col('.') - 1
  return !l:col || getline('.')[l:col - 1]  =~# '\s'
endfunction

function! s:ShowDocumentation() abort
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" :
      \ <SID>CheckBackSpace() ? "\<Tab>" : coc#refresh()
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nnoremap <silent> K :call <SID>ShowDocumentation()<CR>

nmap <silent> <Leader>gD <Plug>(coc-declaration)
nmap <silent> <Leader>gd <Plug>(coc-definition)
nmap <silent> <Leader>gi <Plug>(coc-implementation)
nmap <silent> <Leader>gr <Plug>(coc-references)
nmap <silent> <Leader>gt <Plug>(coc-type-definition)
nmap <silent> <Leader>rf <Plug>(coc-refactor)
nmap <silent> <Leader>rn <Plug>(coc-rename)

nmap <silent> <Leader>fx <Plug>(coc-fix-current)
nmap <silent> <Leader>fh <Plug>(coc-float-hide)
nmap <silent> <Leader>fj <Plug>(coc-float-jump)

nmap <silent> <C-p> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-n> <Plug>(coc-diagnostic-next)
imap <silent> <C-s> <Plug>(coc-snippets-expand)

vmap <silent> <Leader>a <Plug>(coc-codeaction-selected)
nmap <silent> <Leader>a <Plug>(coc-codeaction-selected)

autocmd CursorHold * silent call CocActionAsync('highlight')

let g:coc_global_extensions = [
      \ 'coc-diagnostic', 'coc-git', 'coc-json', 'coc-snippets',
      \ 'coc-spell-checker', 'coc-word']

"--------------------------------------------------------- clangd/coc-clangd{{{
call coc#config('clangd.inlayHints.enable', v:false)
call coc#config('clangd.path', 'clangd')
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
call coc#config('colors.filetypes', ['*'])
"}}}
"--------------------------------------------- coc-extensions/coc-powershell{{{
call coc#config('powershell.powerShellExePath', 'pwsh')
call coc#config('powershell.integratedConsole.showOnStartup', v:false)
"}}}
"----------------------------------------------------- neoclide/coc-snippets{{{
call coc#config('snippets.ultisnips.enable', v:true)
call coc#config('snippets.userSnippetsDirectory', $VIMCONF.'/plugin/coc-snippets')
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

nnoremap <silent> <Leader>ll :execute 'CocCommand latex.Build'<CR>
nnoremap <silent> <Leader>lv :execute 'CocCommand latex.ForwardSearch'<CR>
"}}}

function! s:SetColors() abort
  if g:colors_name ==# 'neucs'
    call neutil#hl#Link('CocInfoSign'   , 'NeuGreen')
    call neutil#hl#Link('CocHintSign'   , 'NeuBlue')
    call neutil#hl#Link('CocWarningSign', 'NeuOrange')
    call neutil#hl#Link('CocErrorSign'  , 'NeuRed')
  endif
endfunction

augroup n_coc
  autocmd!
  autocmd ColorScheme neucs call <SID>SetColors()
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
