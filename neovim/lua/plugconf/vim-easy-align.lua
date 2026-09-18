local M = {}

function M.keymap()
  return {
    {"ga", "<Plug>(EasyAlign)", mode = {"n", "x"}, {noremap = false}},
  }
end

function M.setup()
end

return M
