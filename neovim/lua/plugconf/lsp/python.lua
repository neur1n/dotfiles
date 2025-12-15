local M = {}

function M.setup()
  if vim.fn.executable("basedpyright") then
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
end

return M
