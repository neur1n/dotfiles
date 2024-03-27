local M = {}

function M.setup()
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
