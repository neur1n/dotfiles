# Nushell Environment Config File

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIRS = [
  ($nu.default-config-dir | path join 'module'),
  ($nu.default-config-dir | path join 'script')
]

# Directories to search for plugin binaries when calling register
# By default, <nushell-config-dir>/plugins is added
$env.NU_PLUGIN_DIRS = [
  ($nu.default-config-dir | path join 'plugin')
]

#================================================================= Customize{{{
$env.NUCONF = ($nu.config-path | path expand | path dirname)

let bin = (ls ($"($env.NUCONF)/../bin/($nu.os-info.name)/($nu.os-info.arch)/*" | into glob)).name

$env.Path = (
  if "Path" in $env {
    $env.Path | split row (char esep) | prepend $bin
  } else {
    $env.PATH | split row (char esep) | prepend $bin
  }
)

$env.PATH = (
  if "Path" in $env {
    $env.Path | split row (char esep) | prepend $bin
  } else {
    $env.PATH | split row (char esep) | prepend $bin
  }
)

zoxide init nushell | save -f ~/.zoxide.nu
# Customize}}}
