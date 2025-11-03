local M = {}

function M.keymap()
  return {
    {"<Leader>fb", "<Cmd>lua require('fzf-lua').buffers()<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>fc", "<Cmd>lua require('fzf-lua').command_history()<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>fd", "<Cmd>lua require('fzf-lua').diagnostics_document()<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>ff", "<Cmd>lua require('fzf-lua').files()<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>fg", "<Cmd>lua require('fzf-lua').live_grep_native()<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>fo", "<Cmd>lua require('fzf-lua').oldfiles()<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>fr", "<Cmd>lua require('fzf-lua').files({cwd=require('utility').project_root()})<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>fs", "<Cmd>lua require('fzf-lua').search_history()<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>ft", "<Cmd>lua require('fzf-lua').lsp_document_symbols()<CR>", mode = "n", {noremap = true, silent = true}},
    -- From extensions.
    {"<Leader>fm", "<Cmd>lua require('fzf-lua-foldmarkers').foldmarkers()<CR>", mode = "n", {noremap = true, silent = true}},
  }
end

function M.setup()
  require("fzf-lua").setup({})
end

return M
