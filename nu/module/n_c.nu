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
    --compiler (-c): string = "",   # Pass to -DCMAKE_C(XX)_COMPILER
    --build    (-b): string = "",   # Pass to -DCMAKE_BUILD_TYPE
    --arch     (-a): string = "",   # Specifying architecture
    --src      (-s): string = "..", # Pass to cmake -S
    ...rest        : string] {
  let fc_c = (
      if $compiler == "msvc" {
        "-DCMAKE_C_COMPILER=cl"
      } else if $compiler == "clang" {
        "-DCMAKE_C_COMPILER=clang"
      } else if $compiler == "gcc" {
        "-DCMAKE_C_COMPILER=gcc"
      } else {
        ""
      })

  let fc_cpp = (
      if $compiler == "msvc" {
        "-DCMAKE_CXX_COMPILER=cl"
      } else if $compiler == "clang" {
        "-DCMAKE_CXX_COMPILER=clang++"
      } else if $compiler == "gcc" {
        "-DCMAKE_CXX_COMPILER=g++"
      } else {
        ""
      })

  let fb = (
      if $build == "Debug" {
        "-DCMAKE_BUILD_TYPE=Debug"
      } else if $build == "Release" {
        "-DCMAKE_BUILD_TYPE=Release"
      } else {
        ""
      })

  let fa_c = (
      if not ($compiler == "msvc") {
        if $arch == "32" {
          "-DCMAKE_C_FLAGS=-m32"
        } else if $arch == "64" {
          "-DCMAKE_C_FLAGS=-m64"
        } else {
          ""
        }
      } else {
        ""
      })

  let fa_cpp = (
      if not ($compiler == "msvc") {
        if $arch == "32" {
          "-DCMAKE_CXX_FLAGS=-m32"
        } else if $arch == "64" {
          "-DCMAKE_CXX_FLAGS=-m64"
        } else {
          ""
        }
      } else {
        ""
      })

  let gen = "-G Ninja"
  let exp = "-DCMAKE_EXPORT_COMPILE_COMMANDS=1"
  let extra = $"($rest | str collect ' ')"

  run-external cmake $src $gen $exp $fc_c $fc_cpp $fb $fa_c $fa_cpp $rest

  if ("compile_commands.json" | path exists) {
    cp "compile_commands.json" $src
    echo $"compile_commands.json copied to ($src | path expand)"
  }
}

# export def run-cmake [
#     --compiler (-c): string = "",   # Pass to -DCMAKE_C(XX)_COMPILER
#     --build    (-b): string = "",   # Pass to -DCMAKE_BUILD_TYPE
#     --arch     (-a): string = "",   # Specifying architecture
#     --src      (-s): string = "..", # Pass to cmake -S
#     ...rest        : string
# ] {
#   let fc = (
#       if $compiler == "msvc" {
#         "-DCMAKE_C_COMPILER=cl -DCMAKE_CXX_COMPILER=cl"
#       } else if $compiler == "clang" {
#         "-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++"
#       } else if $compiler == "gcc" {
#         "-DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++"
#       } else {
#         ""
#       })

#   let fb = (
#       if $build == "Debug" {
#         "-DCMAKE_BUILD_TYPE=Debug"
#       } else if $build == "Release" {
#         "-DCMAKE_BUILD_TYPE=Release"
#       } else {
#         ""
#       })

#   let fa = (
#       if not ($compiler == "msvc") {
#         if $arch == "32" {
#           "-DCMAKE_C_FLAGS=-m32 -DCMAKE_CXX_FLAGS=-m32"
#         } else if $arch == "64" {
#           "-DCMAKE_C_FLAGS=-m64 -DCMAKE_CXX_FLAGS=-m64"
#         } else {
#           ""
#         }
#       } else {
#         ""
#       })

#   let gen = "-G Ninja"
#   let exp = "-DCMAKE_EXPORT_COMPILE_COMMANDS=1"
#   let extra = $"($rest | str collect ' ')"

#   # let cmd = $"cmake ($src) -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=1"
#   # let cmd = $cmd + $fc
#   # let cmd = $cmd + $fb
#   # let cmd = $cmd + $fa
#   # let cmd = $cmd + $" ($rest | str collect ' ')"

#   run-external cmake [$src $gen $exp $fc $fb $fa]

#   if ("compile_commands.json" | path exists) {
#     cp "compile_commands.json" $src
#     echo $"compile_commands.json copied to ($src | path expand)"
#   }
# }
