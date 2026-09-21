local M = {}

local function start(buf)
  local ok = pcall(vim.treesitter.start, buf)
  if not ok then
    return
  end

  vim.api.nvim_set_option_value(
    "indentexpr", "v:lua.require('nvim-treesitter').indentexpr()", {buf = buf})

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == buf then
      vim.api.nvim_set_option_value(
        "foldexpr", "v:lua.vim.treesitter.foldexpr()", {win = win})
    end
  end
end

function M.setup()
  local id = vim.api.nvim_create_augroup("n_treesitter", {clear = true})

  vim.api.nvim_create_autocmd("FileType", {
    group = id,
    pattern = "*",
    callback = function(event)
      start(event.buf)
    end,
  })
end

return M
