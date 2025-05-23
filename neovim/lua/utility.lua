local M = {}

local function is_drive_root(path)
  local Env = require("environment")

  if Env.is_win() then
    return path:match("^[a-zA-Z]:[\\/]?$") ~= nil
  else
    return path == "/"
  end
end

function M.project_root()
  local pattern = {".git", ".hg", ".root", ".svn", "package.json"}
  local cwd = vim.fn.getcwd()

  while not is_drive_root(cwd) do
    for _, pat in ipairs(pattern) do
      local marker = cwd .. "/" .. pat
      if vim.fn.isdirectory(marker) == 1 or vim.fn.filereadable(marker) == 1 then
        return cwd
      end
    end

    local parent = vim.fn.fnamemodify(cwd, ":h")
    if parent == cwd then
      break
    end
    cwd = parent
  end

  vim.notify("No project root found. Using current working directory.", vim.log.levels.WARN)
  return vim.fn.getcwd()
end

return M
