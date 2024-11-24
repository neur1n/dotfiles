local M = {}

local border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

function M.setup()
  local Cmp = require("cmp")

  Cmp.setup({
    experimental = {
      ghost_text = false,
    },
    sources = Cmp.config.sources({
      {name = "copilot"},
      {name = "nvim_lsp"},
      {name = "nvim_lsp_signature_help"},
      {name = "path"},
      {name = "vsnip", priority = 100},
    }, {
      {name = "buffer"},
    }),
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
      completion = Cmp.config.window.bordered(),
      documentation = Cmp.config.window.bordered(),
    },
    mapping = Cmp.mapping.preset.insert({
      ["<C-e>"] = Cmp.mapping.abort(),
      ["<C-Space>"] = Cmp.mapping.complete(),
      ["<C-b>"] = Cmp.mapping(function(fallback)
        if Cmp.visible_docs() then
          Cmp.mapping.scroll_docs(-5)
        else
          fallback()
        end
      end, {"i", "s"}),
      ["<C-f>"] = Cmp.mapping(function(fallback)
        if Cmp.visible_docs() then
          Cmp.mapping.scroll_docs(5)
        else
          fallback()
        end
      end, {"i", "s"}),
      ["<CR>"] = Cmp.mapping({
        i = function(fallback)
          if Cmp.visible() then
            if Cmp.get_active_entry() then
              Cmp.confirm({behavior = Cmp.ConfirmBehavior.Replace, select = false})
            else
              Cmp.close()
            end
          else
            fallback()
          end
        end,
        s = Cmp.mapping.confirm({select = true}),
        c = Cmp.mapping.confirm({behavior = Cmp.ConfirmBehavior.Replace, select = false}),
      }),
      ["<Tab>"] = Cmp.mapping(function(fallback)
        if Cmp.visible() then
          Cmp.select_next_item()
        elseif has_words_before() then
          Cmp.complete()
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        else
          fallback()
        end
      end, {"i", "s"}),
      ["<S-Tab>"] = Cmp.mapping(function()
        if Cmp.visible() then
          Cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        end
      end, {"i", "s"}),
    }),
  })

  Cmp.setup.cmdline({"/", "?"}, {
    mapping = Cmp.mapping.preset.cmdline(),
    sources = {
      {name = "buffer"},
    }
  })

  Cmp.setup.cmdline(":", {
    mapping = Cmp.mapping.preset.cmdline(),
    sources = Cmp.config.sources({
      {name = "path"},
    }, {
      {name = "cmdline"},
    })
  })

  Cmp.setup.filetype("gitcommit", {
    sources = Cmp.config.sources({
      {name = "git"},
    }, {
      {name = "buffer"},
    })
  })

  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  require("lspconfig")["clangd"].setup {
    capabilities = capabilities
  }
end

return M
