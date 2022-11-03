use path


fn cmake {|&c="" &b="" &a="" &s=".." @rest|
  var fc = {
    if (eq $c "msvc") {
      put "-DCMAKE_C_COMPILER=cl -DCMAKE_CXX_COMPILER=cl"
    } elif (eq $c "clang") {
      put "-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++"
    } elif (eq $c "gcc") {
      put "-DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++"
    } else {
      put ""
    }
  }

  var fb = {
    if (eq $b "Debug") {
      put "-DCMAKE_BUILD_TYPE=Debug"
    } elif (eq $b "Release") {
      put "-DCMAKE_BUILD_TYPE=Release"
    } else {
      put ""
    }
  }

  var fa = {
    if (not (eq $c "msvc")) {
      if (eq $a 32) {
        put "-DCMAKE_C_FLAGS=-m32 -DCMAKE_CXX_FLAGS=-m32"
      } elif (eq $a 64) {
        put "-DCMAKE_C_FLAGS=-m64 -DCMAKE_CXX_FLAGS=-m64"
      } else {
        put ""
      }
    }
  }

  var gen = "-G Ninja"
  var exp = "-DCMAKE_EXPORT_COMPILE_COMMANDS=1"

  (external cmake) $s $gen $exp $c $b $a $@rest

  if ($path:is-regular~ compile_commands.json) {
    cp "compile_commands.json" $s
    echo (put "compile_commands.json copied to "($path:abs~ $s))
  }
}
