scriptencoding utf-8

let s:spc = ' '
let s:sep = '%=%='
let s:mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'no'  : 'NO',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'VL',
    \ '' : 'VB',
    \ 'r'  : 'Prompt',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ 't': 'TERMINAL',
\ }

let s:startup = 1

function! neur1n#statusline#Update()
    if s:startup
        call s:Construct('active')
        call s:StaticColor()
        call neur1n#statusline#UpdateColor('n')
        let s:startup = 0
    endif

    let l:winnr = winnr()
    let l:line = (winnr('$') == 1) ? [s:Construct('active')] :
        \ [s:Construct('active'), s:Construct('inactive')]
    for l:w in range(1, winnr('$'))
        call setwinvar(l:w, '&statusline', l:line[l:w!=l:winnr])
        call setwinvar(l:w, 'layout_changed', l:w!=l:winnr)
        call setwinvar(l:w, 'inactive', l:w!=l:winnr)
    endfor
endfunction

function! neur1n#statusline#UpdateOnce()
    if !exists('w:layout_changed') || w:layout_changed
        call neur1n#statusline#Update()
    endif
endfunction

function! s:Construct(status)
    return s:Left(a:status).s:sep.s:Right(a:status).
         \ '%{neur1n#statusline#UpdateColor()}'
endfunction

function! s:Left(status)
    if a:status ==# 'active'
        return s:Mode().s:GitBranch().s:Name().s:Modification()
    elseif a:status ==# 'inactive'
        return s:Name().s:Modification()
    endif
endfunction

function! s:Right(status)
    if a:status ==# 'active'
        return s:Tag().s:Info().s:Ruler().s:Warning().s:spc.s:Error()
    elseif a:status ==# 'inactive'
        return s:Ruler()
    endif
endfunction

"******************************************************************************
"                                                                         Parts
"******************************************************************************
function! s:Mode()
    return '%#Mode_# %{neur1n#statusline#Mode()} '
endfunction

function! neur1n#statusline#Mode()
    if &filetype ==# 'help'
        let l:mode = 'HELP'
    " elseif &filetype ==# 'qf'
    "     let l:mode = 'quickfix'
    elseif &filetype ==# 'startify'
        let l:mode = 'startify'
    elseif &filetype ==# 'vim-plug'
        let l:mode = 'vim-plug'
    else
        let l:mode = get(s:mode_map, mode(), mode())
    endif

    let l:mode .= &paste ? ' | PASTE' : ''
    let l:mode .= &spell ? ' | SPELL' : ''

    return l:mode
endfunction

function! s:GitBranch()
    return '%#VCS_#'.(gitbranch#name() ==# '' ? '' : s:spc.'%{gitbranch#name()}')
endfunction

function! s:Name()
    return '%#Name_#'.s:spc.'%n:%f'
endfunction

function! s:Modification()
    let l:modified = '%m'
    let l:readonly = '%{&readonly ? " \ue0a2 " : ""}'
    return '%#Modification_#'.l:modified.l:readonly
endfunction

function! s:Tag()
    return '%#Tag_#'.'%{tagbar#currenttag("%s", "")}'.s:spc
endfunction

function! s:Info()
    " let l:value = '0x%B'
    " let l:type = '%Y'

    if &fileencoding ? &fileencoding : &encoding ==# 'utf-8'
        let l:encoding = ''
    else
        let l:encoding = '%{&fileencoding ? &fileencoding : &encoding}'
    endif

    if &fileformat ==# 'unix'
        let l:fileformat = ''
    else
        let l:fileformat = '[%{&fileformat}]'
    endif

    return '%#Info_#'.l:encoding.l:fileformat
endfunction

function! s:Ruler()
    return '%#Ruler_#'.'%4l/%L:%-3v'
endfunction

function! s:Warning()
    return '%#Warning_#'.'%{neur1n#loclist#Count()[1]}'
endfunction

function! s:Error()
    return '%#Error_#'.'%{neur1n#loclist#Count()[0]}'
endfunction

"******************************************************************************
"                                                                  Highlighting
"******************************************************************************
let s:gui = {
    \ 'base03':  '#002b36',
    \ 'base02':  '#073642',
    \ 'base01':  '#586e75',
    \ 'base00':  '#657b83',
    \ 'base0':   '#839496',
    \ 'base1':   '#93a1a1',
    \ 'base2':   '#eee8d5',
    \ 'base3':   '#fdf6e3',
    \ 'yellow':  '#b58900',
    \ 'orange':  '#cb4b16',
    \ 'red':     '#dc322f',
    \ 'magenta': '#d33682',
    \ 'violet':  '#6c71c4',
    \ 'blue':    '#268bd2',
    \ 'cyan':    '#2aa198',
    \ 'green':   '#859900',
    \ 'bg0_h':   '#1d2021',
    \ 'bg0':     '#282828',
    \ 'bg1':     '#3c3836',
    \ 'gray':    '#928374',
    \ 'purple':  '#b16286',
\ }

let s:term = {
    \ 'base03':  234,
    \ 'base02':  235,
    \ 'base01':  242,
    \ 'base00':   66,
    \ 'base0':   246,
    \ 'base1':   247,
    \ 'base2':   254,
    \ 'base3':   230,
    \ 'yellow':  136,
    \ 'orange':  166,
    \ 'red':     160,
    \ 'magenta': 168,
    \ 'violet':   62,
    \ 'blue':     32,
    \ 'cyan':     36,
    \ 'green':   106,
    \ 'bg0_h':   234,
    \ 'bg0':     235,
    \ 'bg1':     237,
    \ 'gray':    245,
    \ 'purple':  132,
\ }

function! neur1n#statusline#UpdateColor(...)
    for l:w in range(1, winnr('$'))
        if exists('w:inactive') && w:inactive == 1
            call s:InactiveColor()
        else
            let l:mode = a:0 ? a:1 : mode()
            if l:mode =~# '\v(n|no)'
                call s:NormalColor()
            elseif l:mode ==# 'i'
                call s:InsertColor()
            elseif l:mode =~# '\v(v|V|)'
                " elseif s:mode_map[mode()] =~# 'V'
                call s:VisualColor()
            elseif l:mode =~# '\v(r|R)'
                call s:ReplaceColor()
            elseif l:mode ==# 'c'
                call s:CmdlineColor()
            else
                call s:NormalColor()
            endif
        endif
    endfor
    return ''
endfunction

function! s:StaticColor()
    call s:Highlight('VCS_', s:gui.base2, s:gui.base03,
                           \ s:term.base2, s:term.base03, 'bold')
    " call s:Highlight('Modification_', s:gui.red, 'NONE',
    "                                 \ s:term.red, 'NONE', 'bold')
    call s:Highlight('Tag_', s:gui.violet, 'NONE',
                           \ s:term.violet, 'NONE', 'italic')
    call s:Highlight('Info_', s:gui.base01, 'NONE',
                            \ s:term.base01, 'NONE', 'NONE')
    " call s:Highlight('Ruler_', s:gui.base1, 'NONE',
    "                          \ s:term.base1, 'NONE', 'NONE')
    call s:Highlight('Warning_', s:gui.yellow, 'NONE',
                               \ s:term.yellow, 'NONE', 'bold')
    call s:Highlight('Error_', s:gui.red, 'NONE',
                             \ s:term.red, 'NONE', 'bold')
endfunction

function! s:NormalColor()
    call s:Highlight('Mode_', s:gui.base03, s:gui.green,
                            \ s:term.base03, s:term.green, 'bold')
    call s:Highlight('Name_', s:gui.cyan, 'NONE',
                            \ s:term.cyan, 'NONE', 'bold')
    call s:Highlight('Modification_', s:gui.red, 'NONE',
                                    \ s:term.red, 'NONE', 'bold')
    call s:Highlight('Ruler_', s:gui.green, 'NONE',
                             \ s:term.green, 'NONE', 'NONE')
endfunction

function! s:InsertColor()
    call s:Highlight('Mode_', s:gui.base03, s:gui.cyan,
                            \ s:term.base03, s:term.cyan, 'bold')
    call s:Highlight('Name_', s:gui.blue, 'NONE',
                            \ s:term.blue, 'NONE', 'bold')
    call s:Highlight('Modification_', s:gui.red, 'NONE',
                                    \ s:term.red, 'NONE', 'bold')
    call s:Highlight('Ruler_', s:gui.cyan, 'NONE',
                             \ s:term.cyan, 'NONE', 'NONE')
endfunction

function! s:VisualColor()
    call s:Highlight('Mode_', s:gui.base03, s:gui.yellow,
                            \ s:term.base03, s:term.yellow, 'bold')
    call s:Highlight('Name_', s:gui.orange, 'NONE',
                            \ s:term.orange, 'NONE', 'bold')
    call s:Highlight('Modification_', s:gui.red, 'NONE',
                                    \ s:term.red, 'NONE', 'bold')
    call s:Highlight('Ruler_', s:gui.yellow, 'NONE',
                             \ s:term.yellow, 'NONE', 'NONE')
endfunction

function! s:ReplaceColor()
    call s:Highlight('Mode_', s:gui.base03, s:gui.magenta,
                            \ s:term.base03, s:term.magenta, 'bold')
    call s:Highlight('Name_', s:gui.violet, 'NONE',
                            \ s:term.violet, 'NONE', 'bold')
    call s:Highlight('Modification_', s:gui.red, 'NONE',
                                    \ s:term.red, 'NONE', 'bold')
    call s:Highlight('Ruler_', s:gui.magenta, 'NONE',
                             \ s:term.magenta, 'NONE', 'NONE')
endfunction

function! s:CmdlineColor()
    call s:Highlight('Mode_', s:gui.base03, s:gui.red,
                            \ s:term.base03, s:term.red, 'bold')
    call s:Highlight('Name_', s:gui.cyan, 'NONE',
                            \ s:term.cyan, 'NONE', 'bold')
    call s:Highlight('Modification_', s:gui.red, 'NONE',
                                    \ s:term.red, 'NONE', 'bold')
    call s:Highlight('Ruler_', s:gui.red, 'NONE',
                             \ s:term.red, 'NONE', 'NONE')
endfunction

function! s:InactiveColor()
    call s:Highlight('Name_', s:gui.bg0_h, s:gui.bg1,
                            \ s:term.bg0_h, s:term.bg1, 'bold')
    call s:Highlight('Modification_', s:gui.purple, s:gui.bg1,
                                    \ s:term.purple, s:term.bg1, 'bold')
    call s:Highlight('Ruler_', s:gui.bg1, s:gui.bg0_h,
                             \ s:term.bg1, s:term.bg0_h, 'bold')
endfunction

function! s:Highlight(group, guifg, guibg, ctermfg, ctermbg, style)
    exec printf('hi %s guifg=%s guibg=%s ctermfg=%s ctermbg=%s gui=%s',
              \ a:group, a:guifg, a:guibg, a:ctermfg, a:ctermbg, a:style)
endfunction
