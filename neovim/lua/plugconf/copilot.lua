local M = {}

function M.setup()
  require("copilot").setup({
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
end

return M
