scriptencoding utf-8

"********************************************************* cohama/lexima.vim{{{
call lexima#add_rule({'char': '\(', 'input_after': '\)', 'filetype': 'html'})
call lexima#add_rule({'char': '$', 'input_after': '$', 'filetype': 'latex'})
call lexima#add_rule({'char': '$', 'at': '\%#\$', 'leave': 1, 'filetype': 'latex'})
call lexima#add_rule({'char': '<BS>', 'at': '\$\%#\$', 'delete': 1, 'filetype': 'latex'})
"}}}
