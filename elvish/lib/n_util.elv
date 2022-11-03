use platform

var sep = { if $platform:is-windows { put ";" } else { put ":" } }

fn append-path {|x|
  var p = $E:PATH
  set E:PATH = (put $E:PATH($sep)$x)
}
