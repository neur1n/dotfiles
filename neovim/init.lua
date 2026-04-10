require("autocmd").setup()
require("command").setup()
require("environment").setup()
require("keymap").setup()
require("netrw").setup(true)
require("option").setup()
require("quickfix").setup()
require("ui").setup()

require("plugconf.lazy").setup()

if vim.g.neovide then
  require("neovide").setup()
end
