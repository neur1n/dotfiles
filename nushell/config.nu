#================================================================== Override{{{
$env.EDITOR = "nvim"
$env.config.buffer_editor = "nvim"
$env.config.completions.algorithm = "fuzzy"
$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"
$env.config.edit_mode = "vi"
$env.config.footer_mode = "auto"
$env.config.history.file_format = "sqlite"
$env.config.history.isolation = true
$env.config.rm.always_trash = true
# Override}}}

#================================================================= Customize{{{
use nu_wrapper.nu *
source nu_alias.nu
source nu_prompt.nu

const bin_root = ($nu.default-config-dir | path join ".." "bin" | path expand)
source ($bin_root | path join "common" "fast" "fast.nu")

source ($nu.default-config-dir | path join ".zoxide.nu")
# Customize}}}
