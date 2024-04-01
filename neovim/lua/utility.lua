local M = {}

function M.root_dir()
  local patterns = {".git", ".hg", ".root", ".svn", "package.json"}
  local cwd = vim.fn.getcwd()

  while cwd ~= "/" do
    for _, pattern in ipairs(patterns) do
      local marker = cwd .. "/" .. pattern
      if vim.fn.isdirectory(marker) == 1 or vim.fn.filereadable(marker) == 1 then
        return cwd
      end
    end

    cwd = vim.fn.fnamemodify(cwd, ":h")
  end

  return vim.fn.getcwd()
end

return M
