local M = {}

function M.setup()
  vim.g["VM_maps"] = {
    ["Find Under"] = "<M-d>",
    ["Find Subword Under"] = "<M-d>",
  }
end

return M
