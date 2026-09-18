local M = {}

function M.keymap()
  return {
      {"<Leader>zm", "<Cmd>ZenMode<CR>", mode = "n", {noremap = true, silent = true}}
    }
end

function M.setup()
  require("zen-mode").setup({
    enabled = false,
    plugins = {
      options = {
        laststatus = 3,
        showcmd = true,
      }
    },
  })
end

return M
