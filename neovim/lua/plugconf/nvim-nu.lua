local M = {}

function M.setup()
  require("nvim-nu").setup({
    use_lsp_features = false,
  })
end

return M
