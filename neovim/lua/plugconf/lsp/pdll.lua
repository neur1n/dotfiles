local M = {}

function M.setup()
  if vim.fn.executable("mlir-pdll-lsp-server") then
    vim.lsp.enable("mlir-pdll-lsp-server")
  end
end

return M
