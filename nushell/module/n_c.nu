export def init-workspace [...rest: string] {
  let targets = ["debug", "release", "include", "src", "thirdparty"]
  let targets = ($targets | append $rest)

  for t in $targets {
    if not ($t | path exists) {
      mkdir $t | ignore
    }
  }
}

export def run-cmake [
    --build    (-b): string = "",   # Pass to -DCMAKE_BUILD_TYPE
    --compiler (-c): string = "",   # Pass to -DCMAKE_C(XX)_COMPILER
    --arch     (-a): int    = 64,   # Specifying architecture
    --src      (-s): string = "..", # Pass to cmake -S
    ...rest        : string] {
  let args = [
    $"-S ($src)",
    "-G Ninja",
    "-DCMAKE_EXPORT_COMPILE_COMMANDS=1"
  ]

  let tmp = ($build | str downcase)
  let args = (
      if ($tmp == "debug") {
        ($args | append "-DCMAKE_BUILD_TYPE=Debug")
      } else if ($tmp == "release") {
        ($args | append "-DCMAKE_BUILD_TYPE=Release")
      } else {
        $args
      })
  
  let tmp = ($compiler | str downcase)
  let args = (
      if ($tmp == "msvc") {
        ($args | append "-DCMAKE_C_COMPILER=cl" | append "-DCMAKE_CXX_COMPILER=cl")
      } else if ($tmp == "clang") {
        ($args | append "-DCMAKE_C_COMPILER=clang" | append "-DCMAKE_CXX_COMPILER=clang++")
      } else if ($tmp == "gcc") {
        ($args | append "-DCMAKE_C_COMPILER=gcc" | append "-DCMAKE_CXX_COMPILER=g++")
      } else {
        $args
      })

  let args = (
      if not ($tmp == "msvc") {
        if $arch == 32 {
          ($args | append "-DCMAKE_C_FLAGS=-m32" | append "-DCMAKE_CXX_FLAGS=-m32")
        } else if $arch == 64 {
          ($args | append "-DCMAKE_C_FLAGS=-m64" | append "-DCMAKE_CXX_FLAGS=-m64")
        } else {
          $args
        }
      } else {
        $args
      })

  run-external cmake ([$args, $rest] | flatten)

  if ("compile_commands.json" | path exists) {
    cp "compile_commands.json" $src
    echo $"compile_commands.json copied to ($src | path expand)"
  }
}
