local M = {}

function M.keymap()
  return {
    {"<Leader>fb", "<Cmd>lua require('telescope.builtin').buffers()<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>fc", "<Cmd>lua require('telescope.builtin').command_history()<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>fd", "<Cmd>lua require('telescope.builtin').diagnostics({bufnr=0})<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>ff", "<Cmd>lua require('telescope.builtin').find_files()<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>fg", "<Cmd>lua require('telescope.builtin').live_grep()<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>fo", "<Cmd>lua require('telescope.builtin').oldfiles()<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>fr", "<Cmd>lua require('telescope.builtin').find_files({cwd=require('utility').project_root()})<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>fs", "<Cmd>lua require('telescope.builtin').search_history()<CR>", mode = "n", {noremap = true, silent = true}},
    {"<Leader>ft", "<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", mode = "n", {noremap = true, silent = true}},
    -- From extensions.
    {"<Leader>fm", "<Cmd>Telescope foldmarkers<CR>", mode = "n", {noremap = true, silent = true}},
  }
end

function M.setup()
  local theme = require("telescope.themes").get_ivy()
  theme["path_display"] = {"truncate"}

  require("telescope").setup({
    defaults = theme,
    extensions = {
      fzf = {
        fuzzy = true,
        case_mode = "smart_case",
        override_file_sorter = true,
        override_generic_sorter = true,
      },
    }
  })

  require("telescope").load_extension("foldmarkers")
  require("telescope").load_extension("fzf")
end

return M
