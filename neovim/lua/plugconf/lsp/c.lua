local M = {}

function M.setup()
  if vim.fn.executable("clangd") then
    vim.lsp.config("clangd", {
      cmd = {
        "clangd",
        "--offset-encoding=utf-16",
      },
    })

    vim.lsp.enable("clangd")
  end
end

return M
