local M = {}

function M.keymap()
  return {
    {"<Leader>mf", "<Cmd>lua MiniFiles.open()<CR>", mode = {"n"}, {noremap = true, silent = true}},
  }
end

function M.setup()
  require("mini.files").setup()
end

return M
