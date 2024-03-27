local M = {}

function M.setup()
  vim.g["VM_maps"] = {
    ["Find Under"] = "<C-d>",
    ["Find Subword Under"] = "<C-d>",
  }
end

return M
