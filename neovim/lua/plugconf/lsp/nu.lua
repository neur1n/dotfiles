local M = {}

function M.setup()
  if vim.fn.executable("nu") then
    vim.lsp.enable("nushell")
  end
end

return M
