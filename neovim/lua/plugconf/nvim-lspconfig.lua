local M = {}

function M.setup()
  vim.diagnostic.config({
    severity_sort = true,
    underline = true,
    update_in_insert = false,
    virtual_text = false,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "🔥",
        [vim.diagnostic.severity.WARN] = "⚡",
        [vim.diagnostic.severity.INFO] = "🔎",
        [vim.diagnostic.severity.HINT] = "💡",
      },
    },
  })

  local id = vim.api.nvim_create_augroup("n_lsp", {clear = true})

  vim.api.nvim_create_autocmd("LspAttach", {
    group = id,
    callback = function(event)
      local opt = {buffer = event.buf}
      vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration, opt)
      vim.keymap.set("n", "<Leader>gt", vim.lsp.buf.type_definition, opt)
      vim.keymap.set("n", "<Leader>gf", function()
        vim.lsp.buf.format{async = true}
      end, opt)
    end,
  })

  vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
    group = id,
    pattern = "*",
    callback = function ()
      vim.diagnostic.open_float({
        scope="cursor",
        -- NOTE: These are used by `vim.lsp.util.open_floating_preview` internally.
        close_events = {
          "BufHidden",
          "CursorMoved",
          "CursorMovedI",
          "InsertCharPre",
          "WinLeave",
        },
        focusable = false,
      })
    end,
  })

  require("plugconf.lsp.c").setup()
  require("plugconf.lsp.lua").setup()
  require("plugconf.lsp.mlir").setup()
  require("plugconf.lsp.nu").setup()
  require("plugconf.lsp.pdll").setup()
  require("plugconf.lsp.python").setup()
  require("plugconf.lsp.tablegen").setup()
  require("plugconf.lsp.tex").setup()
end

return M
