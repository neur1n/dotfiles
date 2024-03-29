local M = {}

function M.keymap()
  return {
    {"<C-j>", "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-j>'", mode = {"i", "s"}, {noremap = true, expr = true}},
    {"<C-k>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'", mode = {"i", "s"}, {noremap = true, expr = true}},
  }
end

function M.setup()
  vim.g["vsnip_extra_mapping"] = false

  vim.g["vsnip_snippet_dir"] = vim.fn.stdpath("config") .. "/lua/plugconf/snippets"

  vim.g["vsnip_filetypes"] = {
    cpp = {"c"},
    cuda = {"c"},
  }

  vim.keymap.set({"i", "s"}, "<C-j>", function()
    if vim.fn["vsnip#jumpable"](1) then
      return "<Plug>(vsnip-jump-next)"
    else
      return "<C-j>"
    end
  end, {noremap = true, expr = true})

  vim.keymap.set({"i", "s"}, "<C-k>", function()
    if vim.fn["vsnip#jumpable"](-1) then
      return "<Plug>(vsnip-jump-prev)"
    else
      return "<C-k>"
    end
  end, {noremap = true, expr = true})
end

return M
