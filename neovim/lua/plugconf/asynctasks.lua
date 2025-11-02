local M = {}

function M.keymap()
  return {
    {"<Leader>as", "<Cmd>AsyncStop<CR>", mode = "n", {noremap = true}},
    {"<Leader>ab", "<Cmd>AsyncTask file-build<CR>", mode = "n", {noremap = true}},
    {"<Leader>ar", "<Cmd>AsyncTask file-run<CR>", mode = "n", {noremap = true}},
  }
end

function M.setup()
  vim.g["asynctasks_config_name"] = vim.fn.stdpath("config") .. "/lua/plugconf/asynctasks.ini"
end

return M
