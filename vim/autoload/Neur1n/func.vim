" *****************************************************************************
"                                                                      Diagnose
" *****************************************************************************
function! Neur1n#func#DiagnosticCount() abort
    let l:loclist = getloclist(0)
    let l:e_cnt = 0
    let l:w_cnt = 0
    let l:first_e = !empty(l:loclist) ? l:loclist[-1].lnum : ''
    let l:first_w = !empty(l:loclist) ? l:loclist[-1].lnum : ''
    " let l:first_e = ''
    " let l:first_w = ''

    for l:item in l:loclist
        if l:item.type is# 'E'
            let l:e_cnt += 1
        endif
        if l:item.type is# 'W'
            let l:w_cnt += 1
        endif

        if l:e_cnt == 1
            let l:first_e = l:item.lnum < l:first_e ? l:item.lnum : l:first_e
            " let l:first_e = l:item.lnum
        endif
        if l:w_cnt == 1
            let l:first_w = l:item.lnum < l:first_w ? l:item.lnum : l:first_w
            " let l:first_w = l:item.lnum
        endif
    endfor

    let l:e_cnt = l:e_cnt == 0 ? '' : ' '.l:e_cnt.'('.l:first_e.')'
    let l:w_cnt = l:w_cnt == 0 ? '' : '⚡'.l:w_cnt.'('.l:first_w.')'
    return [l:e_cnt, l:w_cnt]
endfunction

function! Neur1n#func#DiagnosticJump(direction, wrap) abort
    let l:nearest = Neur1n#func#DiagnosticGetNearest(a:direction, a:wrap)

    if !empty(l:nearest)
        normal! m`
        call cursor(l:nearest)
    endif
endfunction

function! Neur1n#func#DiagnosticGetNearest(direction, wrap) abort
    let l:cur_lnum = getcurpos()[1]
    let l:loclist = getloclist(0)

    if a:direction is# 'prev'
        call reverse(l:loclist)
    endif

    for l:item in l:loclist
        if a:direction is# 'prev' && l:cur_lnum > l:item.lnum
            return [l:item.lnum, l:item.col]
        endif

        if a:direction is# 'next' && l:cur_lnum < l:item.lnum
            return [l:item.lnum, l:item.col]
        endif
    endfor

    if a:wrap && !empty(l:loclist)
        return [l:loclist[0].lnum, l:loclist[0].col]
    endif

    return []
endfunction

" *****************************************************************************
"                                                                       Editing
" *****************************************************************************
"                                              Toggle relative line number: \rn
function! Neur1n#func#ToggleRelLnr()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunction
"                                                         Toggle read only: \ro
function Neur1n#func#ToggleReadOnly()
    if &readonly == 1
        setl noreadonly
        if has('conceal')
            setl conceallevel=2 cocu=i
        endif
    else
        setl readonly
        if has('conceal')
            setl conceallevel=2 cocu=cn
        endif
    endif
endfunction
"                                                    Delete hidden buffers: \db
function Neur1n#func#DelHiddenBuf()
    let l:tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(l:tpbl, tabpagebuflist(v:val))')
    for l:buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(l:tpbl, v:val)==-1')
        silent execute 'bwipeout' l:buf
    endfor
endfunction

" *****************************************************************************
"                                                                  Run or Build
" *****************************************************************************
"                                                                            Go
function! Neur1n#func#RunGo()
    if filereadable('MAINFILE')
        let l:file_id = readfile('MAINFILE')
        execute '!go run '.l:file_id[0]
    else
        execute '!go run %'
    endif
endfunction
"                                                                          Keil
function! Neur1n#func#RunKeil(options)
    let l:target = ''

    if !empty(glob('*.uvprojx'))
        let l:target =  glob('*.uvprojx')
    elseif !empty(glob('../../*.uvprojx'))
        let l:target =  glob('../../*.uvprojx')
    endif

    if !empty(l:target)
        execute 'wa'
        execute ':silent !uv4 '.a:options.l:target.' -o "\%TEMP\%/log.txt"'
        execute ':sp $TEMP/log.txt'
        execute 'normal! Gzz'
    else
        echo 'Target not found!'
    endif
endfunction
"                                                                      Markdown
function! Neur1n#func#ViewMarkdown()
    let l:browser = 'E:\ProgramFiles\Opera\launcher.exe'
    execute 'silent !'.l:browser.' %'
endfunction
"                                                                        Python
function! Neur1n#func#RunPython()
    if filereadable('MAINFILE')
        let l:file_id = readfile('MAINFILE')
        execute '!python '.l:file_id[0]
    else
        execute '!python %'
    endif
endfunction
