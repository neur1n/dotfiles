local M = {}

function M.keymap()
  return {
    {"<Leader>as", "<Cmd>AsyncStop<CR>", mode = "n", {noremap = true}},
    {"<Leader>pi", "<Cmd>AsyncTask project-init<CR>", mode = "n", {noremap = true}},
    {"<Leader>pb", "<Cmd>AsyncTask project-build<CR>", mode = "n", {noremap = true}},
    {"<Leader>pr", "<Cmd>AsyncTask project-run<CR>", mode = "n", {noremap = true}},
    {"<Leader>fb", "<Cmd>AsyncTask file-build<CR>", mode = "n", {noremap = true}},
    {"<Leader>fr", "<Cmd>AsyncTask file-run<CR>", mode = "n", {noremap = true}},
  }
end

function M.setup()
  vim.g["asynctasks_config_name"] = vim.fn.stdpath("config") .. "/lua/plugconf/asynctasks.ini"
end

return M
