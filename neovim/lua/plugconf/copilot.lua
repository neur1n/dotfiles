local M = {}

function M.setup()
  require("copilot").setup({
    filetypes = {
      bib = true,
      markdown = true,
      tex = true,
      text = true,
      ["*"] = false,
    },
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = "<M-l>",
        accept_word = "<M-w>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<M-e>",
      },
    },
  })

  local id = vim.api.nvim_create_augroup("n_copilot", {clear = true})

  vim.api.nvim_create_autocmd("User", {
    group = id,
    pattern = "BlinkCmpMenuOpen",
    callback = function()
      vim.b.copilot_suggestion_hidden = true
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    group = id,
    pattern = "BlinkCmpMenuClose",
    callback = function()
      vim.b.copilot_suggestion_hidden = false
    end,
  })
end

return M
