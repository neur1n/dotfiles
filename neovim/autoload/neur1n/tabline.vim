scriptencoding utf-8

let s:modified = '✎'
let s:read_only = ''
let s:unnamed = '*'

function! neur1n#tabline#GetBufDict() abort
    let l:bufdict = {'nr': [], 'name': []}
    for l:bufnr in tabpagebuflist()
        " let l:bufdict.nr += [l:bufnr]
        " let l:bufdict.name += [bufname(l:bufnr)]
        let l:bufdict.nr = add(l:bufdict.nr, l:bufnr)
        let l:bufdict.name = add(l:bufdict.name, bufname(l:bufnr))
    endfor
    return l:bufdict
endfunction

function! neur1n#tabline#GetLabelDict(bufdict) abort
    let l:ldict = {}
    " let l:modified = &modified ?  : ''
    " let l:bufdict = neur1n#tabline#GetBufDict()

    if !empty(a:bufdict)
        for l:bufnr in a:bufdict.nr
            let l:ldict[l:bufnr] = l:bufnr.':'.simplify(bufname(l:bufnr))
        endfor
    endif
    return l:ldict
endfunction

function! s:GetBufName(bufnr) abort
    let l:name = bufname(a:bufnr)

    if l:name ==# ''
        let l:name = s:unnamed
    else
        let l:name = a:bufnr.':'.pathshorten(l:name)
    endif

    if s:IsReadOnly(a:bufnr)
        let l:name .= s:read_only
    endif

    if getbufvar(a:bufnr, '&modified')
        let l:name .= s:modified
    endif
    return substitute(l:name, '%', '%%', 'g')
endfunction

function! s:IsReadOnly(bufnr)
    let l:modifiable = getbufvar(a:bufnr, '&modifiable')
    let l:readonly = getbufvar(a:bufnr, '&readonly')
    return (l:readonly || !l:modifiable) && getbufvar(a:bufnr, '&filetype') !=# 'help'
endfunction
