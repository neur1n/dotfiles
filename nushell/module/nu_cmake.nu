# Single-config generators accept one configuration; multi-config generators
# accept a semicolon-separated list. Native -D options override the shortcuts.
export def --wrapped config [
  --compiler: string  # clang, gcc, or msvc; otherwise use the toolchain default.
  --config-type: string
  --generator (-G): string = "Ninja Multi-Config"
  --source-dir: path = ".."
  ...args  # Arguments falling through to CMake.
] {
  mut default = [
    "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON",
    "-G", $generator,
    "-S", $source_dir
  ]

  if ($config_type != null) {
    let kind = (classify-generator $generator)
    let name = ($config_type | split row ";" | each {|n| normalize-config $n})

    if ($name | any {|n| $n | str trim | is-empty}) {
      error make {
        msg: "--config-type must contain non-empty configuration names"
      }
    }

    if ($kind == "single") and (($name | length) != 1) {
      error make {
        msg: $"Generator '($generator)' accepts only one --config-type"
      }
    }

    let variable = if ($kind == "multi") {
      "CMAKE_CONFIGURATION_TYPES"
    } else {
      "CMAKE_BUILD_TYPE"
    }

    $default = ($default | append $"-D($variable)=($name | str join ';')")
  }

  if ($compiler != null) {
    let compilers = match ($compiler | str lowercase) {
      "clang" => ["clang", "clang++"]
      "gcc" => ["gcc", "g++"]
      "msvc" => ["cl", "cl"]
      _ => {error make {msg: "--compiler must be clang, gcc, or msvc"}}
    }

    $default = ($default | append [
      $"-DCMAKE_C_COMPILER=($compilers.0)"
      $"-DCMAKE_CXX_COMPILER=($compilers.1)"
    ])
  }

  ^cmake ...$default ...$args
}

export def --wrapped build [
  --build-dir: path = "."
  --config: string
  ...args  # Arguments falling through to CMake.
] {
  run-action "--build" $build_dir $config $args
}

export def --wrapped install [
  --build-dir: path = "."
  --config: string
  ...args  # Arguments falling through to CMake.
] {
  run-action "--install" $build_dir $config $args
}

def normalize-config [name: string] {
  match ($name | str lowercase) {
    "debug" => "Debug"
    "release" => "Release"
    "relwithdebinfo" => "RelWithDebInfo"
    "minsizerel" => "MinSizeRel"
    _ => $name
  }
}

# https://cmake.org/cmake/help/v4.5/manual/cmake-generators.7.html
# https://cmake.org/cmake/help/v4.5/prop_gbl/GENERATOR_IS_MULTI_CONFIG.html
def classify-generator [generator: string] {
  # Deprecated extra generators have the form "<extra> - <main>".
  let main = ($generator | split row " - " | last)

  if (($main in ["Ninja Multi-Config", "Xcode"])
    or ($main | str starts-with "Visual Studio ")) {
    "multi"
  } else if ($main in [
    "Borland Makefiles",
    "FASTBuild",
    "Green Hills MULTI",
    "MinGW Makefiles",
    "MSYS Makefiles",
    "Ninja",
    "NMake Makefiles",
    "NMake Makefiles JOM",
    "Unix Makefiles",
    "Watcom WMake"
  ]) {
    "single"
  } else {
    error make {
      msg: $"Unsupported generator for automatic configuration mapping: ($generator)"
      help: "Omit --config-type and use native -D configuration options to let CMake handle this generator."
    }
  }
}

def run-action [action: string, binary: path, config: any, args: list<any>] {
  let config_args = if ($config == null) {
    []
  } else {
    ["--config", (normalize-config $config)]
  }

  ^cmake $action $binary ...$config_args ...$args
}
