local M = {}

local function has_words_before()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end

  unpack = unpack or table.unpack
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]:sub(col, col):match("%s") == nil
end

function M.setup()
  local Blink = require("blink.cmp")

  Blink.setup({
    completion = {
      list = {
        selection = {preselect = false}
      }
    },
    fuzzy = {implementation = "prefer_rust_with_warning"},
    sources = {
      default = {"buffer", "lsp", "path", "snippets"},
      providers = {
        snippets = {
          opts = {
            extended_filetypes = {
              cpp = {"c"},
              cuda = {"c", "cpp"},
            },
          },
        },
      },
    },
    keymap = {
      preset = "none",
      ["<M-y>"] = {"accept", "fallback"},
      ["<M-e>"] = {"cancel", "fallback"},
      ["<M-b>"] = {"scroll_documentation_up", "fallback"},
      ["<M-f>"] = {"scroll_documentation_down", "fallback"},
      ["<C-j>"] = {"snippet_forward", "fallback"},
      ["<C-k>"] = {"snippet_backward", "fallback"},
      ["<CR>"] = {
        function(blink)
          if blink.is_menu_visible() then
            if blink.get_selected_item() then
              return blink.accept()
            else
              return blink.hide()
            end
          end
        end,
        "fallback"
      },
      ["<Tab>"] = {
        function(blink)
          if blink.is_menu_visible() then
            if #blink.get_items() == 1 then
              return blink.select_and_accept()
            else
              return blink.select_next()
            end
          elseif blink.snippet_active() then
            return blink.snippet_forward()
          elseif has_words_before() then
            blink.show()
            if #blink.get_items() == 1 then
              return blink.select_and_accept()
            end
          end
        end,
        "fallback"
      },
      ["<S-Tab>"] = {
        function(blink)
          if blink.is_menu_visible() then
            return blink.select_prev()
          elseif blink.snippet_active() then
            return blink.snippet_backward()
          end
        end,
        "fallback"
      },
    },
    cmdline = {
      keymap = {
        preset = "none",
        ["<CR>"] = {
          function(blink)
            if blink.is_menu_visible() then
              if blink.get_selected_item() then
                return blink.accept()
              else
                return blink.hide()
              end
            end
          end,
          "fallback"
        },
        ["<Tab>"] = {"show_and_insert", "select_next"},
        ["<S-Tab>"] = {"show_and_insert", "select_prev"},
      },
    }
  })
end

return M
