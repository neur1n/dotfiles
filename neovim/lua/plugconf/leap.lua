local M = {}

function M.keymap()
  return {
    {"t", "<Plug>(leap-forward-to)", mode = {"n", "o", "x"}, {noremap = true}},
    {"T", "<Plug>(leap-backward-to)", mode = {"n", "o", "x"}, {noremap = true}},
  }
end

function M.setup()
  require("leap").add_repeat_mappings("<End>", "<Home>", {
    relative_directions = true,
    modes = {"n", "x", "o"},
  })
end

return M
