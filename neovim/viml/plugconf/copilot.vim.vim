scriptencoding utf-8

let g:copilot_no_tab_map = v:true

inoremap <silent><script><expr> <C-s> copilot#Accept('\<CR>')
inoremap <silent> <C-]> <Plug>(copilot-accept-word)
