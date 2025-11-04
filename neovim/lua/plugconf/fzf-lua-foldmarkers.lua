local M = {}

function M.setup()
  require("fzf-lua-foldmarkers").setup({
    on_jump = function()
      vim.cmd("normal! zz")
    end,
  })
end

return M
