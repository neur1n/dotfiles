local M = {}

function M.toggle()
  local current = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]
  if current.quickfix == 1 then
    vim.cmd(current.loclist == 1 and "lclose" or "cclose")
    return
  end

  local loclist = vim.fn.getloclist(0, {winid = 0, size = 0})
  if loclist.winid ~= 0 then
    vim.cmd("lclose")
  elseif vim.fn.getqflist({winid = 0}).winid ~= 0 then
    vim.cmd("cclose")
  else
    -- Prefer this window's non-empty location list; otherwise use quickfix.
    local winid = vim.api.nvim_get_current_win()
    vim.cmd(loclist.size > 0 and "botright lopen" or "botright copen")
    vim.api.nvim_set_current_win(winid)
  end
end

function M.setup()
  -- Clear the quickfix
  vim.keymap.set("n", "_", function()
    vim.fn.setqflist({}, "f")
    vim.cmd("botright copen")
    vim.cmd("wincmd p")
  end, {noremap = true, silent = true})

  -- Toggle the current location list or quickfix.
  vim.keymap.set("n", "+", M.toggle, {noremap = true, silent = true})
end

return M
