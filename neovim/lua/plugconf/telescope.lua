local M = {}

function M.keymap()
  return {
    {"<Leader>sb", "<Cmd>lua require('telescope.builtin').buffers()<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>sc", "<Cmd>lua require('telescope.builtin').command_history()<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>sf", "<Cmd>lua require('telescope.builtin').find_files()<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>sg", "<Cmd>lua require('telescope.builtin').live_grep()<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>sh", "<Cmd>lua require('telescope.builtin').oldfiles()<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>sr", "<Cmd>lua require('telescope.builtin').find_files({cwd=require('utility').root_dir()})<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>ss", "<Cmd>lua require('telescope.builtin').search_history()<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>st", "<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", mode = "n", {noremap = true, silent = true}},
  }
end

function M.setup()
  require("telescope").setup({
    extensions = {
      fzf = {
        fuzzy = true,
        case_mode = "smart_case",
        override_file_sorter = true,
        override_generic_sorter = true,
      },
    }
  })

  require("telescope").load_extension("fzf")
end

return M
