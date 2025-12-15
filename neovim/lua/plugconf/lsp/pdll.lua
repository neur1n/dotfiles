local M = {}

function M.setup()
  if vim.fn.executable("mlir-pdll-lsp-server") then
    vim.lsp.enable("mlir_pdll_lsp_server")
  end
end

return M
