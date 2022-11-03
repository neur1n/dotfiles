use path
use n_c
use n_key
use n_ppt
use n_util


set edit:prompt-stale-threshold = 1.0

var cwd = ($path:dir~ ($path:eval-symlinks~ (src)[name]))

ls -d $cwd/../bin/*/* | each { |x| $n_util:append-path~ $x}

eval (zoxide init elvish | slurp)

set edit:abbr["ncmk"] = "$n_c:cmake~ "
