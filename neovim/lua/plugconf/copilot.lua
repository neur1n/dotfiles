local M = {}

function M.setup()
  vim.g.copilot_no_tab_map = true

  vim.keymap.set("i", "<M-l>", "<Plug>(copilot-accept-line)", {noremap = true})
  vim.keymap.set("i", "<M-w>", "<Plug>(copilot-accept-word)", {noremap = true})
  vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", {noremap = true})
  vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)", {noremap = true})
end

return M
