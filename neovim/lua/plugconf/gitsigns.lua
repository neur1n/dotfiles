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

      vim.keymap.set("n", "[d", gs.prev_hunk, {noremap = true})
      vim.keymap.set("n", "]d", gs.next_hunk, {noremap = true})
      vim.keymap.set("n", "<Leader>hd", gs.preview_hunk, {noremap = true})
    end
  })
end

return M
