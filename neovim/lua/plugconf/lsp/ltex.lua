local M = {}

function M.setup(handlers)
  require("lspconfig").ltex.setup({
    settings = {
      ltex = {language = "en-US"},
    },
    handlers = handlers,
  })
end

return M
