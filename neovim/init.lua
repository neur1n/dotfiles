require("plugconf.lazy").setup()

require("autocmd").setup()
require("colorscheme").setup()
require("command").setup()
require("environment").setup()
require("filetype").setup()
require("keymap").setup()
require("netrw").setup()
require("option").setup()
require("quickfix").setup()

if vim.g.neovide then
  require("neovide").setup()
end
