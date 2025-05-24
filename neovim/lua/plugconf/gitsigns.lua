local M = {}

function M.setup()
  require("gitsigns").setup({
    signs = {
      add          = {text = "+"},
      change       = {text = "~"},
      delete       = {text = "_"},
      topdelete    = {text = "‾"},
      changedelete = {text = "≃"},
      untracked    = {text = "┆"},
    },
    on_attach = function()
      local gs = package.loaded.gitsigns

      vim.keymap.set("n", "[h", function() gs.nav_hunk("prev") end, {noremap = true})
      vim.keymap.set("n", "]h", function() gs.nav_hunk("next") end, {noremap = true})
      vim.keymap.set("n", "<Leader>ph", gs.preview_hunk, {noremap = true})
    end
  })
end

return M
