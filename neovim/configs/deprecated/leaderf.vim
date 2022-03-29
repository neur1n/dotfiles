scriptencoding utf-8

"********************************************************** Yggdroot/LeaderF{{{
let g:Lf_CursorBlink = 0
let g:Lf_DefaultExternalTool = 'rg'
let g:Lf_ShowHidden = 1
let g:Lf_RecurseSubmodules = 1
let g:Lf_RememberLastSearch = 1
let g:Lf_RootMarkers = ['.git', '.hg', '.svn', '.root']
let g:Lf_StlColorscheme = 'gruvbox_material'
let g:Lf_WorkingDirectoryMode = 'Aa'
let g:Lf_WindowPosition = 'popup'

nnoremap <Leader>m :<Plug>LeaderMru<CR>
nnoremap <Leader>g :<Plug>LeaderfRgPrompt<CR>
"}}}
