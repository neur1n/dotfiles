scriptencoding utf-8

"******************************************************** mhinz/vim-startify{{{
let s:greetings = {
      \ 'hello': ['██╗   ██╗ ████████╗ ██╗       ██╗        ██████╗ ',
      \           '██║   ██║ ██╔═════╝ ██║       ██║       ██╔═══██╗',
      \           '████████║ ██████╗   ██║       ██║       ██║   ██║',
      \           '██╔═══██║ ██╔═══╝   ██║       ██║       ██║   ██║',
      \           '██║   ██║ ████████╗ ████████╗ ████████╗ ╚██████╔╝',
      \           '╚═╝   ╚═╝ ╚═══════╝ ╚═══════╝ ╚═══════╝  ╚═════╝ '
      \          ],
      \ 'neovim': ['███╗  ██╗ ████████╗  ██████╗  ██╗     ██╗ ██╗ ███╗   ███╗',
      \            '████╗ ██║ ██╔═════╝ ██╔═══██╗  ██╗   ██╔╝ ██║ ████╗ ████║',
      \            '██╔██╗██║ ██████╗   ██║   ██║   ██╗ ██╔╝  ██║ ██╔████╔██║',
      \            '██║╚████║ ██╔═══╝   ██║   ██║    ████╔╝   ██║ ██║╚██╔╝██║',
      \            '██║ ╚███║ ████████╗ ╚██████╔╝     ██╔╝    ██║ ██║ ╚═╝ ██║',
      \            '╚═╝  ╚══╝ ╚═══════╝  ╚═════╝      ╚═╝     ╚═╝ ╚═╝     ╚═╝'
      \        ],
      \ 'vim': ['██╗     ██╗ ██╗ ███╗   ███╗',
      \         ' ██╗   ██╔╝ ██║ ████╗ ████║',
      \         '  ██╗ ██╔╝  ██║ ██╔████╔██║',
      \         '   ████╔╝   ██║ ██║╚██╔╝██║',
      \         '    ██╔╝    ██║ ██║ ╚═╝ ██║',
      \         '    ╚═╝     ╚═╝ ╚═╝     ╚═╝'
      \        ],
      \ }

let s:animals = {
      \ 'cow': ['       o',
      \         '        o   ^__^',
      \         '         o  (oo)\_______',
      \         '            (__)\       )\/\',
      \         '                ||----w |',
      \         '                ||     ||',
      \         ],
      \ 'lion': ['       o',
      \          '        o    ____',
      \          '         o  /    \',
      \          '           | ^__^ |',
      \          '           | (oo) |______',
      \          '           | (__) |      )\/\',
      \          '            \____/|----w |',
      \          '                 ||     ||'
      \          ],
      \ 'moose': ['       o',
      \           '        o   \_\_    _/_/',
      \           '         o      \__/',
      \           '                (oo)\_______',
      \           '                (__)\       )\/\',
      \           '                    ||----w |',
      \           '                    ||     ||'
      \           ],
      \ }

let g:startify_fortune_use_unicode = 1
let g:startify_session_dir = '$VIMCONFIG/recovery/session'

if strftime('%M') % 3 == 0
  let s:greeting = startify#fortune#boxed()
elseif strftime('%M') % 3 == 1
  let s:greeting = s:greetings['hello']
else
  if has('nvim')
    let s:greeting = s:greetings['neovim']
  else
    let s:greeting = s:greetings['vim']
  endif
endif

if strftime('%H') < 12
  let s:animal = s:animals['cow']
elseif strftime('%H') < 18
  let s:animal = s:animals['lion']
else
  let s:animal = s:animals['moose']
endif
let g:startify_custom_header = map(s:greeting + s:animal, "\"   \".v:val")
"}}}
