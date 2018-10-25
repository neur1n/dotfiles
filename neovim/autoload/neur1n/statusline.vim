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
    return '%#Name_#'.s:spc.'%n:%{expand("%:p:h:t")}/%t'
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

    " if &fileencoding ? &fileencoding : &encoding ==# 'utf-8'
    "     let l:encoding = ''
    " else
    let l:encoding = '%{&fileencoding ? &fileencoding : &encoding}'
    " endif

    " if &fileformat ==# 'unix'
    "     let l:fileformat = ''
    " else
    let l:fileformat = '%{&fileformat}'
    " endif

    return '%#Info_#%Y'.'['.l:encoding.':'.l:fileformat.']'
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
" exec 'source $VIMCONFIG/configs/palette.vim'
if g:colors_name ==# 'gruvbox'
    let s:scheme = 'g:gruvbox'
elseif g:colors_name ==# 'solarized'
    let s:scheme = 'g:solarized'
endif

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
    exec printf("call s:Highlight('VCS_', %s.vcs[0], %s.bg[0], %s.vcs[1], %s.bg[1], 'bold')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
    exec printf("call s:Highlight('Tag_', %s.tag[0], %s.bg[0], %s.tag[1], %s.bg[1], 'italic')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
    exec printf("call s:Highlight('Info_', %s.info[0], %s.bg[0], %s.info[1], %s.bg[1], 'NONE')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)

    exec printf("call s:Highlight('Warning_', %s.warning[0], %s.bg[0], %s.warning[1], %s.bg[1], 'bold')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
    exec printf("call s:Highlight('Error_', %s.error[0], %s.bg[0], %s.error[1], %s.bg[1], 'bold')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
endfunction

function! s:NormalColor()
    exec printf("call s:Highlight('Mode_', %s.bg[0], %s.nor[0], %s.bg[1], %s.nor[1], 'bold')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
    exec printf("call s:Highlight('Name_', %s.nornam[0], %s.bg[0], %s.nornam[1], %s.bg[1], 'bold')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
    exec printf("call s:Highlight('Modification_', %s.modact[0], %s.bg[0], %s.modact[1], %s.bg[1], 'bold')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
    exec printf("call s:Highlight('Ruler_', %s.nor[0], %s.bg[0], %s.nor[1], %s.bg[1], 'NONE')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
endfunction

function! s:InsertColor()
    exec printf("call s:Highlight('Mode_', %s.bg[0], %s.ins[0], %s.bg[1], %s.ins[1], 'bold')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
    exec printf("call s:Highlight('Name_', %s.insnam[0], %s.bg[0], %s.insnam[1], %s.bg[1], 'bold')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
    exec printf("call s:Highlight('Modification_', %s.modact[0], %s.bg[0], %s.modact[1], %s.bg[1], 'bold')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
    exec printf("call s:Highlight('Ruler_', %s.ins[0], %s.bg[0], %s.ins[1], %s.bg[1], 'NONE')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
endfunction

function! s:VisualColor()
    exec printf("call s:Highlight('Mode_', %s.bg[0], %s.vis[0], %s.bg[1], %s.vis[1], 'bold')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
    exec printf("call s:Highlight('Name_', %s.visnam[0], %s.bg[0], %s.visnam[1], %s.bg[1], 'bold')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
    exec printf("call s:Highlight('Modification_', %s.modact[0], %s.bg[0], %s.modact[1], %s.bg[1], 'bold')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
    exec printf("call s:Highlight('Ruler_', %s.vis[0], %s.bg[0], %s.vis[1], %s.bg[1], 'NONE')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
endfunction

function! s:ReplaceColor()
    exec printf("call s:Highlight('Mode_', %s.bg[0], %s.rep[0], %s.bg[1], %s.rep[1], 'bold')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
    exec printf("call s:Highlight('Name_', %s.repnam[0], %s.bg[0], %s.repnam[1], %s.bg[1], 'bold')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
    exec printf("call s:Highlight('Modification_', %s.modact[0], %s.bg[0], %s.modact[1], %s.bg[1], 'bold')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
    exec printf("call s:Highlight('Ruler_', %s.rep[0], %s.bg[0], %s.rep[1], %s.bg[1], 'NONE')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
endfunction

function! s:CmdlineColor()
    exec printf("call s:Highlight('Mode_', %s.bg[0], %s.cmd[0], %s.bg[1], %s.cmd[1], 'bold')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
    exec printf("call s:Highlight('Name_', %s.cmdnam[0], %s.bg[0], %s.cmdnam[1], %s.bg[1], 'bold')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
    exec printf("call s:Highlight('Modification_', %s.modact[0], %s.bg[0], %s.modact[1], %s.bg[1], 'bold')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
    exec printf("call s:Highlight('Ruler_', %s.cmd[0], %s.bg[0], %s.cmd[1], %s.bg[1], 'NONE')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
endfunction

function! s:InactiveColor()
    exec printf("call s:Highlight('Name_', %s.bg[0], %s.bgi[0], %s.bg[1], %s.bgi[1], 'bold')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
    exec printf("call s:Highlight('Modification_', %s.modina[0], %s.bgi[0], %s.modina[1], %s.bgi[1], 'bold')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
    exec printf("call s:Highlight('Ruler_', %s.bgi[0], %s.bg[0], %s.bgi[1], %s.bg[1], 'NONE')",
                \ s:scheme, s:scheme, s:scheme, s:scheme)
endfunction

function! s:Highlight(group, guifg, guibg, ctermfg, ctermbg, style)
    exec printf('hi %s guifg=%s guibg=%s ctermfg=%s ctermbg=%s gui=%s cterm=%s',
              \ a:group, a:guifg, a:guibg, a:ctermfg, a:ctermbg, a:style, a:style)
endfunction
