local M = {}

function M.setup()
  require("gitsigns").setup({
    signs = {
      add          = { text = "+" },
      change       = { text = "~" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "≃" },
      untracked    = { text = "┆" },
    },
    on_attach = function()
      local gs = package.loaded.gitsigns

      vim.keymap.set("n", "[d", function()
        gs.prev_hunk({preview = true})
      end, {noremap = true})

      vim.keymap.set("n", "]d", function()
        gs.next_hunk({preview = true})
      end, {noremap = true})
    end
  })
end

return M
