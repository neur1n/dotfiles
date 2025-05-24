local M = {}

function M.setup()
  vim.g["vsnip_extra_mapping"] = false

  vim.g["vsnip_snippet_dir"] = vim.fn.stdpath("config") .. "/lua/plugconf/snippets"

  vim.g["vsnip_filetypes"] = {
    cpp = {"c"},
    cuda = {"c"},
  }

  vim.keymap.set({"i", "s"}, "<M-j>", function()
    if vim.fn["vsnip#jumpable"](1) then
      return "<Plug>(vsnip-jump-next)"
    else
      return "<M-j>"
    end
  end, {noremap = true, expr = true})

  vim.keymap.set({"i", "s"}, "<M-k>", function()
    if vim.fn["vsnip#jumpable"](-1) then
      return "<Plug>(vsnip-jump-prev)"
    else
      return "<M-k>"
    end
  end, {noremap = true, expr = true})
end

return M
