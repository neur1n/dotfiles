local M = {}

function M.keymap()
  return {
    {"<Leader>tg", require("nvim-toggler").toggle, mode = {"n", "v"}, {noremap = true}},
  }
end

function M.setup()
  require("nvim-toggler").setup({
    remove_default_keybinds = true,
    inverses = {
      ["True"] = "False"
    },
  })
end

return M
