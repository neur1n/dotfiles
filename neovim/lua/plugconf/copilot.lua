local M = {}

function M.setup()
  vim.g.copilot_no_tab_map = true

  vim.keymap.set("i", "<M-l>", "copilot#Accept('')", {noremap = true, expr = true, replace_keycodes = false})
  vim.keymap.set("i", "<M-w>", "<Plug>(copilot-accept-word)", {noremap = true})
  vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", {noremap = true})
  vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)", {noremap = true})
end

return M
