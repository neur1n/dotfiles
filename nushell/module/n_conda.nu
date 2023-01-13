use n_os.nu


export-env {
  let info = (mamba info --envs --json | from json)

  let-env CONDA_BASE_PATH = (if (n_os is-windows) {$env.Path} else {$env.PATH})

  let-env CONDA_ROOT = $info.root_prefix

  let-env CONDA_ENVS = ($info.envs | reduce -f {} {|it, acc|
      if $it == $info.root_prefix {
        $acc | upsert "base" $it
      } else {
        $acc | upsert ($it | path basename) $it
      }})

  let-env CONDA_CURR = null
}

export def-env activate [name: string] {
  if not $name in $env.CONDA_ENVS {
    echo $"Environment ($name) is invalid. Available:"
    echo $env.CONDA_ENVS
    return
  }

  let new_path = (
    if "Path" in $env {
      update-path-windows ($env.CONDA_ENVS | get $name)
    } else {
      update-path-linux ($env.CONDA_ENVS | get $name)
    })

  load-env ({CONDA_CURR: $name} | merge $new_path)
}

export def-env deactivate [] {
  let path = if "Path" in (env).name { "Path" } else { "PATH" }
  let-env $path = $env.CONDA_BASE_PATH
  
  let-env CONDA_CURR = null
}

def update-path-linux [env_path: path] {
  let env_path = [
    $env_path,
    ([$env_path, "bin"] | path join)
  ]

  return {PATH: ($env.PATH | prepend $env_path)}
}

def update-path-windows [env_path: path] {
  let env_path = [
    $env_path,
    ([$env_path, "Scripts"] | path join),
  ]

  return {Path: ($env.Path | prepend $env_path)}
}
