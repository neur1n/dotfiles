local M = {}

function M.setup()
  vim.lsp.config("basedpyright", {
    settings = {
      basedpyright = {
        analysis = {
          typeCheckingMode = "standard",
        }
      }
    },
  })

  vim.lsp.enable("basedpyright")
end

return M
