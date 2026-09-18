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
const bin_root = ($nu.config-path | path expand | path dirname | path join ".." "bin" | path expand)
let bin_list = (ls ($"($bin_root)/($nu.os-info.name)/($nu.os-info.arch)/*" | into glob)).name
$env.PATH = ($env.PATH | split row (char esep) | prepend $bin_list | prepend $"($bin_root)/common")

zoxide init nushell | save -f ~/.zoxide.nu
# Customize}}}
