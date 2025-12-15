local M = {}

function M.setup()
  if vim.fn.executable("mlir-lsp-server") then
    vim.lsp.enable("mlir-lsp-server")
  end
end

return M
