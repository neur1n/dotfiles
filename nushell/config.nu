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
use n_c.nu
use n_utility.nu
source n_prompt.nu
source ~/.zoxide.nu

alias c-init = n_c init-workspace
alias c-cmake = n_c run-cmake
alias c-build = n_c run-build
alias c-install = n_c run-install

alias gco = git checkout
alias glg = git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%ai%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all

alias neovim = n_util neovim
# Customize}}}
