local M = {}

function M.setup()
  vim.diagnostic.config({
    severity_sort = true,
    underline = true,
    update_in_insert = false,
    virtual_text = false,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.INFO] = "",
        [vim.diagnostic.severity.HINT] = "󰵚",
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
        vim.lsp.buf.format({async = true})
      end, opt)
    end,
  })

  vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
    group = id,
    pattern = "*",
    callback = function()
      vim.diagnostic.open_float({
        scope = "cursor",
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

  vim.lsp.log.set_level(vim.log.levels.ERROR)

  if vim.fn.executable("basedpyright-langserver") == 1 then
    vim.lsp.enable("basedpyright")
  end

  if vim.fn.executable("clangd") == 1 then
    vim.lsp.enable("clangd")
  end

  if vim.fn.executable("lua-language-server") == 1 then
    vim.lsp.enable("lua_ls")
  end

  if vim.fn.executable("nu") == 1 then
    vim.lsp.enable("nushell")
  end

  if vim.fn.executable("texlab") == 1 then
    vim.lsp.enable("texlab")
    vim.keymap.set("n", "<Leader>tb", "<Cmd>LspTexlabBuild<CR>", {noremap = true})
    vim.keymap.set("n", "<Leader>tf", "<Cmd>LspTexlabForward<CR>", {noremap = true})
  end
end

return M
