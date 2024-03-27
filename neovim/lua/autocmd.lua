local M = {}

function M.setup()
  local id = vim.api.nvim_create_augroup("neur1n", {clear = true})

  vim.api.nvim_create_autocmd("BufEnter", {
    group = id,
    pattern = "*",
    command = "silent! lcd %:p:h"
  })

  vim.api.nvim_create_autocmd("BufReadPost", {
    group = id,
    pattern = "*",
    callback = function()
      local mark = vim.api.nvim_buf_get_mark(0, "\"")
      local lcnt = vim.api.nvim_buf_line_count(0)
      if mark[1] >= 1 and mark[1] <= lcnt and vim.bo.filetype ~= "commit" then
        vim.api.nvim_win_set_cursor(0, mark)
      end
    end
  })

  vim.api.nvim_create_autocmd({"ModeChanged", "WinEnter", "WinLeave"}, {
    group = id,
    pattern = "*",
    callback = function()
      local mode = vim.api.nvim_get_mode().mode
      if mode == "v" or mode == "V" or mode == "\x16" then
        vim.o.relativenumber = true
      else
        vim.o.relativenumber = false
      end
    end
  })

  vim.api.nvim_create_autocmd({"BufWinEnter", "VimResized" ,"WinEnter"}, {
    group = id,
    pattern = "*",
    callback = function()
      vim.wo.scrolloff = math.floor(vim.api.nvim_win_get_height(0) / 3)
      vim.wo.sidescrolloff = math.floor(vim.api.nvim_win_get_width(0) / 3)
    end
  })

  vim.api.nvim_create_autocmd("WinEnter", {
    group = id,
    pattern = "*",
    callback = function()
      if vim.fn.winnr("$") == 1 and vim.bo.buftype == "quickfix" then
        vim.cmd("q")
      end
    end
  })

end

return M
