local M = {}

function M.setup()
  vim.g.neovide_cursor_animation_length = 0

  if vim.fn.has("mac") == 1 then
    vim.g.neovide_input_use_logo = true

    local function paste()
      local text = vim.fn.system("pbpaste")
      vim.api.nvim_paste(text, true, -1)
    end

    vim.keymap.set({"n", "i", "v", "c", "t"}, "<D-v>", paste, {noremap = true})
  end
end

return M
