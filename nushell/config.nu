#================================================================== Override{{{
$env.config.buffer_editor = "nvim"
$env.config.completions.algorithm = "fuzzy"
$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"
$env.config.edit_mode = "vi"
$env.config.footer_mode = "auto"
$env.config.history.file_format = "sqlite"
$env.config.history.isolation = true
$env.config.rm.always_trash = true
$env.config.shell_integration.osc133 = false
# Override}}}

#================================================================= Customize{{{
use nu_c.nu
use nu_utility.nu
source nu_prompt.nu
source ~/.zoxide.nu

alias c-cmake = nu_c run-cmake
alias c-build = nu_c run-build
alias c-install = nu_c run-install

alias gco = git checkout
alias glg = git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%ai%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all

alias neovim = nu_utility neovim
# Customize}}}
