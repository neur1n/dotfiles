scriptencoding utf-8

nnoremap <silent> _ :call neutil#qf#Clear()<CR>
nnoremap <silent> + :call neutil#qf#Toggle()<CR>

command! DeleteHiddenBuffers silent call neutil#buf#DeleteHidden()
command! ToggleReadOnly silent call neutil#buf#ToggleReadOnly()
command! ToggleRelativeLineNumber silent call neutil#buf#ToggleRelativeLineNumber()
command! TrimTrailingWhitespace silent call neutil#buf#TrimTrailingWhitespace()
command! TabToSpace silent call neutil#buf#TabToSpace()

augroup neutil
  autocmd!
  autocmd WinEnter * if winnr('$') == 1 && &buftype ==# 'quickfix' | q | endif
augroup END
