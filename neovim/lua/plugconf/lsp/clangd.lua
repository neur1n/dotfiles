local M = {}

function M.setup()
  require("lspconfig").clangd.setup({
    cmd = {
      "clangd",
      "--offset-encoding=utf-16",
    }
  })
end

return M
