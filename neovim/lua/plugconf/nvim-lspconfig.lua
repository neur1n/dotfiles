local M = {}

function M.setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(event)
      local opt = {buffer = event.buf}
      vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration, opt)
      vim.keymap.set("n", "<Leader>gt", vim.lsp.buf.type_definition, opt)
      vim.keymap.set("n", "<Leader>gf", function()
        vim.lsp.buf.format{async = true}
      end, opt)
    end,
  })

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
    virtual_lines = {
      current_line = true,
    },
  })

  require("plugconf.lsp.basedpyright").setup()
  require("plugconf.lsp.clangd").setup()
  require("plugconf.lsp.lua_ls").setup()
  require("plugconf.lsp.ltex").setup()
  require("plugconf.lsp.texlab").setup()
end

return M
