local M = {}

local root_marker = {
  ".root",
  {
    ".git",
    ".hg",
    ".svn",
  },
  {
    "Cargo.toml",
    "CMakeLists.txt",
    "package.json",
    "pyproject.toml",
    "setup.py",
  },
}

function M.project_root()
  local cwd = vim.fn.getcwd()
  local root = vim.fs.root(cwd, root_marker)

  if not root then
    vim.notify("No project root found. Using current working directory.", vim.log.levels.WARN)
    return cwd
  end

  return root
end

return M
