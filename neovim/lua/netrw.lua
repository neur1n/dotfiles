local M = {}

function M.setup(enable)
  if enable then
    vim.g.netrw_altv = "nosplitright"
    vim.g.netrw_browse_split = 4
    vim.g.netrw_liststyle = 3
    vim.g.netrw_winsize = 30
  else
    vim.g.loaded_netrw = true
    vim.g.loaded_netrwPlugin = true
  end
end

return M
