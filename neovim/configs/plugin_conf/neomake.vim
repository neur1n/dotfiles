scriptencoding utf-8

"************************************************************* {neomake/neomake
call neomake#configure#automake({
      \   'TextChanged': {},
      \   'InsertLeave': {},
      \   'BufWritePost': {'delay': 0},
      \   'BufWinEnter': {},
      \ }, 500)

let g:neomake_error_sign = {'text': '✘'}
let g:neomake_warning_sign = {'text': ''}
let g:neomake_message_sign = {'text': ''}
let g:neomake_info_sign = {'text': ''}

let g:neomake_cpp_enabled_makers = ['clang', 'cpplint']
let g:neomake_cpp_clang_exe = 'clang-7'
let g:neomake_cpp_cpplint_exe = 'cpplint'

let g:neomake_c_enabled_makers = ['clang']
let g:neomake_c_clang_exe = 'clang-7'

let g:neomake_python_enabled_makers = ['pyflakes', 'pycodestyle']
let g:neomake_python_pyflakes_exe = 'pyflakes'
let g:neomake_python_pycodestyle_exe = 'pycodestyle'
" }
