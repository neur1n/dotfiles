local M = {}

function M.setup()
  local Lspconfig = require("lspconfig")

  require("plugconf.lsp.clangd").setup()
  require("plugconf.lsp.lua_ls").setup()
  require("plugconf.lsp.texlab").setup()
  Lspconfig.pyright.setup({})

  vim.keymap.set("n", "<C-p>", vim.diagnostic.goto_prev, {noremap = true})
  vim.keymap.set("n", "<C-n>", vim.diagnostic.goto_next, {noremap = true})

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

      local opts = {buffer = ev.buf}
      vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "<Leader>gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "<Leader>gt", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references, opts)
      vim.keymap.set({"n", "v"}, "<Leader>ga", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<Leader>gf", function()
        vim.lsp.buf.format{async = true}
      end, opts)
      vim.keymap.set("n", "K", function()
        local clients = vim.lsp.get_active_clients()
        if clients then
          for _, client in pairs(clients) do
            if client.server_capabilities.hoverProvider then
              vim.lsp.buf.hover()
              return
            end
          end
        end

        vim.api.nvim_feedkeys("K", "in", true)
      end, opts)
    end,
  })

  vim.diagnostic.config({
    severity_sort = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    virtual_text = false,
  })

  local signs = {Error = "🔥", Warn = "⚡", Hint = "💡", Info = "🔎"}
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
  end

  vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
    group = vim.api.nvim_create_augroup("float_diagnostic", {clear = true}),
    callback = function ()
      vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
    end
  })
end

return M
