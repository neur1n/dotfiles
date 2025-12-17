local M = {}

function M.setup()
  local id = vim.api.nvim_create_augroup("n_treesitter", {clear = true})

  vim.api.nvim_create_autocmd("FileType", {
    group = id,
    pattern = {"<filetype>"},
    callback = function ()
      vim.treesitter.start()
      vim.bo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
    end,
  })
end

return M
