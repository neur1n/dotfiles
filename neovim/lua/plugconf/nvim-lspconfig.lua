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
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border}),
}

local signs = {Error = "🔥", Warn = "⚡", Hint = "💡", Info = "🔎"}

function M.setup()
  require("plugconf.lsp.basedpyright").setup(handlers)
  require("plugconf.lsp.clangd").setup(handlers)
  require("plugconf.lsp.lua_ls").setup(handlers)
  require("plugconf.lsp.ltex").setup(handlers)
  require("plugconf.lsp.texlab").setup(handlers)

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
    end,
  })

  vim.diagnostic.config({
    severity_sort = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    virtual_text = false,
  })

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
  end

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
