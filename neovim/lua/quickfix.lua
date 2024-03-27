local M = {}

function M.opened()
  for n = 1, vim.fn.winnr("$") do
    if vim.fn.getwinvar(n, "&filetype") == "qf" then
      return true
    end
  end

  return false
end

function M.setup()
  vim.keymap.set("n", "<CR>", "&buftype ==# 'quickfix' ? '<CR>' : 'o<Esc>'", {noremap = true, expr = true})
  vim.keymap.set("n", "<S-CR>", "&buftype ==# 'quickfix' ? '<CR>' : 'O<Esc>'", {noremap = true, expr = true})

  -- Clear the quickfix
  vim.keymap.set("n", "_", function()
    vim.fn.setqflist({}, "f")
    vim.cmd("botright copen")
    vim.cmd("wincmd p")
  end, {noremap = true, silent = true})

  -- Toggle the quickfix
  vim.keymap.set("n", "+", function()
    if M.opened() then
      vim.cmd("cclose")
    else
      vim.cmd("botright copen")
      vim.cmd("wincmd p")
    end
  end, {noremap = true, silent = true})
end

return M
