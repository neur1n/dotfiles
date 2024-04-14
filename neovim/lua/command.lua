local M = {}

function M.setup()
  vim.api.nvim_create_user_command("DeleteHiddenBuffer", function()
    local buflist = vim.api.nvim_list_bufs()

    for _, bufnr in ipairs(buflist) do
      if not vim.api.nvim_buf_get_option(bufnr, "buflisted") then
        vim.api.nvim_buf_delete(bufnr, {force = false})
      end
    end
  end, {})

  vim.api.nvim_create_user_command("TabToSpace", function()
    vim.cmd("silent! execute '%s/\t/  /g'")
  end, {})

  vim.api.nvim_create_user_command("ToggleSpell", function()
    vim.wo.spell = not(vim.opt.spell:get())
  end, {})

  vim.api.nvim_create_user_command("ToggleStatusline", function()
    if vim.o.laststatus == 2 then
      vim.o.laststatus = 3
    else
      vim.o.laststatus = 2
    end
  end, {})

  vim.api.nvim_create_user_command("TrimTrailingWhitespace", function()
    vim.cmd("silent! execute '%s/\\s\\+$//g'")
  end, {})
end

return M
