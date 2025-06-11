local M = {}

local border = {
  {"╭", "FloatBorder"},
  {"─", "FloatBorder"},
  {"╮", "FloatBorder"},
  {"│", "FloatBorder"},
  {"╯", "FloatBorder"},
  {"─", "FloatBorder"},
  {"╰", "FloatBorder"},
  {"│", "FloatBorder"},
}
local handler = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = border}),
}

function M.setup()
  require("plugconf.lsp.basedpyright").setup(handler)
  require("plugconf.lsp.clangd").setup(handler)
  require("plugconf.lsp.lua_ls").setup(handler)
  require("plugconf.lsp.ltex").setup(handler)
  require("plugconf.lsp.texlab").setup(handler)

  vim.keymap.set("n", "<M-p>", function() vim.diagnostic.jump({count = -1, float = false}) end, {noremap = true})
  vim.keymap.set("n", "<M-n>", function() vim.diagnostic.jump({count = 1, float = false}) end, {noremap = true})

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
      numhl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
        [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
        [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
        [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      },
    },
  })

  vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
    group = vim.api.nvim_create_augroup("float_diagnostic", {clear = true}),
    callback = function ()
      local curr = vim.api.nvim_win_get_cursor(0)
      local last = vim.w.lsp_cursor or {nil, nil}

      if (curr[1] ~= last[1]) or (curr[2] ~= last[2]) then
        vim.w.lsp_cursor = curr
        vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
      end
    end
  })
end

return M
