scriptencoding utf-8

"********************************************************** {mhinz/vim-startify
let g:startify_fortune_use_unicode = 1
let g:startify_session_dir = '$VIMCONFIG/recovery/session'

if strftime('%M') % 3 == 0
  let b:greeting = startify#fortune#boxed()
elseif strftime('%M') % 3 == 1
  let b:greeting = b:greetings['hello']
else
  let b:greeting = b:greetings['vim']
endif

if strftime('%H') < 12
  let b:animal = b:animals['cow']
elseif strftime('%H') < 18
  let b:animal = b:animals['lion']
else
  let b:animal = b:animals['moose']
endif
let g:startify_custom_header = map(b:greeting + b:animal, "\"   \".v:val")
" }
