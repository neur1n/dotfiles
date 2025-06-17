local M = {}

function M.setup()
  vim.lsp.config("clangd", {
    cmd = {
      "clangd",
      "--offset-encoding=utf-16",
    },
  })

  vim.lsp.enable("clangd")
end

return M
