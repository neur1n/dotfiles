local M = {}

function M.setup()
  if vim.fn.executable("tblgen-lsp-server") then
    vim.lsp.enable("tblgen-lsp-server")
  end
end

return M
