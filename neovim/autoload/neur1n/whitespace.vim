scriptencoding utf-8

function! neur1n#whitespace#NextTrailing() abort
    let l:pos = searchpos('\v(\s+$)', 'cnw')

    if l:pos[0] == 0
        return {'pos': [], 'info': ''}
    else
        return {'pos': l:pos, 'info': 'Ξ'.'('.l:pos[0].')'}
    endif
endfunction
