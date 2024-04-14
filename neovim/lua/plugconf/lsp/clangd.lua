local M = {}

function M.setup(handlers)
  require("lspconfig").clangd.setup({
    cmd = {
      "clangd",
      "--offset-encoding=utf-16",
    },
    handlers = handlers,
  })
end

return M
