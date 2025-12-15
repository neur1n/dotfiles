local M = {}

function M.setup()
  if vim.fn.executable("mlir-lsp-server") then
    vim.lsp.enable("mlir_lsp_server")
  end
end

return M
