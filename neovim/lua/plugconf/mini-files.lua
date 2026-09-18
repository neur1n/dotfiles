local M = {}

function M.keymap()
  return {
    {"<Leader>mf", "<Cmd>lua MiniFiles.open()<CR>", mode = {"n"}, {noremap = true, silent = true}},
  }
end

function M.setup()
  require("mini.files").setup()

  local id = vim.api.nvim_create_augroup("n_mini", {clear = true})

  vim.api.nvim_create_autocmd('User', {
    group = id,
    pattern = "MiniFilesWindowOpen",
    callback = function(args)
      vim.wo[args.data.win_id].winblend = 0
    end,
  })
end

return M
