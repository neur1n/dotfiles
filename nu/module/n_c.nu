export def run-cmake [
  --arch     (-a): int    = 64,       # Specifying architecture
  --build    (-b): string = "Debug",  # Pass to -DCMAKE_BUILD_TYPE
  --compiler (-c): string = "clang",  # Pass to -DCMAKE_C(XX)_COMPILER
  --src      (-s): string = "..",     # Pass to cmake -S
] {
  let fa = (if $arch == 32 {"-m32"} else {"-m64"})
  let fb = (if $build == "Debug" {"Debug"} else {"Release"})
  let fc = (if $compiler == "msvc" {"cl"} else if $compiler == "gcc" {"gcc"} else {"clang"})
  let fcxx = (if $compiler == "msvc" {"cl"} else if $compiler == "gcc" {"g++"} else {"clang++"})

  let cmd = $"cmake ($src) -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=1"
  let cmd = $cmd + $" -DCMAKE_C_FLAGS=($fa)"
  let cmd = $cmd + $" -DCMAKE_CXX_FLAGS=$($fa)"
  let cmd = $cmd + $" -DCMAKE_BUILD_TYPE=($fb)"
  let cmd = $cmd + $" -DCMAKE_C_COMPILER=($fc)"
  let cmd = $cmd + $" -DCMAKE_CXX_COMPILER=($fcxx)"

  run-external $cmd

  if ("compile_commands.json" | path exists) {
    cp "compile_commands.json" $src
    echo $"compile_commands.json copied to ($src | path expand)"
  }
}
