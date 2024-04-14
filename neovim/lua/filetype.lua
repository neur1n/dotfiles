local M = {}

function M.setup()
  vim.filetype.add({
    extension = {
      nu = "nu",
    }
  })
end

return M
