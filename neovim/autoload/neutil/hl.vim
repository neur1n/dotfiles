scriptencoding utf-8

" @brief Creates new highlight group(s).
" @param[in] group   : Name of the target highlight group.
" @param[in] fg?     : Should be a number (256 RGB), string (HEX RGB), or a
"                      table. If a table is provided, it should follow the
"                      format (for example):
"                        {'c': 167, 'g': '#dd6151'}
"                      where 'c' for cterm, 'g' for gui.
"                      If not provided, 'NONE' is used.
" @param[in] bg?     : Same as fg. If not provided, use value of fg.
" @param[in] attr?   : If not provided, 'NONE' is used.
" @param[in] special?: If not provided, 'NONE' is used.
" @param[in] gui?    : If not provided, 'NONE' is used.
" @param[in] font?   : If not provided, 'NONE' is used.
" @param[in] blend?  : If not provided, 0 is used.
function! neutil#hl#Create(group, fg = 'NONE', bg = 'NONE', attr = 'NONE', sp = 'NONE', font = 'NONE', blend=0) abort
  let l:ctermfg = 'NONE'
  let l:ctermbg = 'NONE'
  let l:guifg = 'NONE'
  let l:guibg = 'NONE'
  let l:attr = 'NONE'
  let l:sp = 'NONE'
  let l:font = 'NONE'
  let l:blend = 0

  if type(a:fg) == v:t_dict
    let l:ctermfg = a:fg.c
    let l:guifg = a:fg.g
  elseif type(a:fg) == v:t_string || type(a:fg) == v:t_number
    let l:ctermfg = a:fg
    let l:guifg = a:fg
  endif

  if type(a:bg) == v:t_dict
    let l:ctermbg = a:bg.c
    let l:guibg = a:bg.g
  elseif type(a:bg) == v:t_string || type(a:bg) == v:t_number
    let l:ctermbg = a:bg
    let l:guibg = a:bg
  endif

  if type(a:attr) == v:t_string
    let l:attr = a:attr
  endif

  if type(a:sp) == v:t_string
    let l:sp = a:sp
  endif

  if type(a:font) == v:t_string
    let l:font = a:font
  endif

  if type(a:blend) == v:t_number
    let l:font = a:blend
  endif

  let l:cmd = [
        \ 'highlight!', a:group,
        \ 'cterm='.l:attr, 'ctermfg='.l:ctermfg, 'ctermbg='.l:ctermbg,
        \ 'gui='.l:attr, 'guifg='.l:guifg, 'guibg='.l:guibg,
        \ 'guisp='.l:sp, 'font='.l:font, 'blend='.l:blend
        \ ]

  execute join(l:cmd, ' ')
endfunction

function! neutil#hl#Clear(group) abort
  execute 'highlight! clear ' . a:group
endfunction

function! neutil#hl#Link(from, to) abort
  execute printf('highlight! link %s %s', a:from, a:to)
endfunction
