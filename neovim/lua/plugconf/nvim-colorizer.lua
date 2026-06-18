local M = {}

function M.setup()
  require("colorizer").setup({
    options = {
      parsers = {
        hex = {rrggbbaa = true},
        names = {enable = false},
      },
    },
  })
end

return M
