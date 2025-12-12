require("autocmd").setup()
require("colorscheme").setup()
require("command").setup()
require("environment").setup()
require("keymap").setup()
require("netrw").setup(false)
require("option").setup()
require("quickfix").setup()

require("plugconf.lazy").setup()

if vim.g.neovide then
  require("neovide").setup()
end
