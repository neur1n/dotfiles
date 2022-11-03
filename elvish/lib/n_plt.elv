var special = ["#4f86f7" "#e2be7d"]

var clack = [
    &bgh=     "#16161d"
    &bgm=     "#1f1f2a"
    &bgs=     "#292937"
    &fgh=     "#faebd7"
    &fgm=     "#fafafa"
    &fgs=     "#fffff0"
    &grayh=   "#464646"
    &graym=   "#4e4e4e"
    &grays=   "#5f5f5f"
    &red=     "#dd6151"
    &orange=  "#ffac00"
    &yellow=  "#f2c700"
    &green=   "#93c247"
    &cyan=    "#69d0a5"
    &blue=    "#5991ae"
    &purple=  "#d37ba2"
    &special= "#4f86f7"
]

var gruvbox = [
    &bgh=     "#1d2021"
    &bgm=     "#282828"
    &bgs=     "#32302f"
    &fgh=     "#d5c4a1"
    &fgm=     "#ebdbb2"
    &fgs=     "#fbf1c7"
    &grayh=   "#7c6f64"
    &graym=   "#928374"
    &grays=   "#a89984"
    &red=     "#fb4934"
    &orange=  "#fe8019"
    &yellow=  "#fabd2f"
    &green=   "#b8bb26"
    &cyan=    "#8ec07c"
    &blue=    "#83a598"
    &purple=  "#d3869b"
    &special= "#4f86f7"
]

var iceberg = [
    &bgh=     "#0f1117"
    &bgm=     "#161822"
    &bgs=     "#1e2132"
    &fgh=     "#c7c9d1"
    &fgm=     "#d2d4de"
    &fgs=     "#e8e9ec"
    &grayh=   "#3e445e"
    &graym=   "#444b71"
    &grays=   "#6b7089"
    &red=     "#e27878"
    &orange=  "#e2a578"
    &yellow=  "#fabd2f"
    &green=   "#b5bf82"
    &cyan=    "#89b9c2"
    &blue=    "#84a0c7"
    &purple=  "#a093c8"
    &special= "#4f86f7"
]

var onedark = [
    &bgh=     "#24272e"
    &bgm=     "#282c34"
    &bgs=     "#3a3f4b"
    &fgh=     "#969faf"
    &fgm=     "#abb2bf"
    &fgs=     "#b3b9c5"
    &grayh=   "#525964"
    &graym=   "#5c6370"
    &grays=   "#697180"
    &red=     "#ef596f"
    &orange=  "#d19a66"
    &yellow=  "#e5c07b"
    &green=   "#89ca78"
    &cyan=    "#2bbac5"
    &blue=    "#61afef"
    &purple=  "#d55fde"
    &special= "#e2be7d"
]

var palettes = [
    &clack=   $clack
    &gruvbox= $gruvbox
    &iceberg= $iceberg
    &onedark= $onedark
]

var pkeys = [
    "clack"
    "gruvbox"
    "iceberg"
    "onedark"
]

fn get-palette {|&name="random"|
  var s = $special[(randint (count $special))]

  if (or (eq $name "random") (not (has-key $palettes $name))) {
    var i = (randint (count $pkeys))
    var k = $pkeys[$i]
    put (assoc $palettes[$k] $special $s)
  } else {
    put (assoc $palettes[$name] $special $s)
  }
}

fn get-rainbow {|plt|
  put [
      $plt[red]
      $plt[orange]
      $plt[yellow]
      $plt[green]
      $plt[blue]
      $plt[cyan]
      $plt[purple]
  ]
}
