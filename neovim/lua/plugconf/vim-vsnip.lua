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
end

return M
