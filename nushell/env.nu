# Nushell Environment Config File

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str collect (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str collect (char esep) }
  }
}

# Directories to search for scripts when calling source or use
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
  ($nu.config-path | path dirname | path join 'module'),
  ($nu.config-path | path dirname | path join 'script')
]

# Directories to search for plugin binaries when calling register
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
  ($nu.config-path | path dirname | path join 'plugin')
]

#================================================================= Customize{{{
let-env NUCONF = ($nu.config-path | path expand | path dirname)

let-env Path = (
  if "Path" in $env {
    $env.Path | split row (char esep) | prepend (ls $"($env.NUCONF)/../bin/*/*").name
  } else {
    $env.PATH | split row (char esep) | prepend (ls $"($env.NUCONF)/../bin/*/*").name
  }
)

let-env PATH = (
  if "Path" in $env {
    $env.Path | split row (char esep) | prepend (ls $"($env.NUCONF)/../bin/*/*").name
  } else {
    $env.PATH | split row (char esep) | prepend (ls $"($env.NUCONF)/../bin/*/*").name
  }
)

zoxide init nushell | save -f ~/.zoxide.nu
# Customize}}}
