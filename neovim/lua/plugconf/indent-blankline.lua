local M = {}


function M.setup()
  local rainbow = {
    "IBLRainbowRed",
    "IBLRainbowOrange",
    "IBLRainbowYellow",
    "IBLRainbowGreen",
    "IBLRainbowCyan",
    "IBLRainbowBlue",
    "IBLRainbowPurple",
  }

  local hooks = require("ibl.hooks")

  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "IBLRainbowRed", {fg = "#E06C75"})
    vim.api.nvim_set_hl(0, "IBLRainbowOrange", {fg = "#D19A66"})
    vim.api.nvim_set_hl(0, "IBLRainbowYellow", {fg = "#E5C07B"})
    vim.api.nvim_set_hl(0, "IBLRainbowGreen", {fg = "#98C379"})
    vim.api.nvim_set_hl(0, "IBLRainbowCyan", {fg = "#56B6C2"})
    vim.api.nvim_set_hl(0, "IBLRainbowBlue", {fg = "#61AFEF"})
    vim.api.nvim_set_hl(0, "IBLRainbowPurple", {fg = "#C678DD"})
  end)

  require("ibl").setup({
    enabled = false,
    indent = {highlight = rainbow},
    whitespace = {highlight = "Normal"},
  })
end

return M
