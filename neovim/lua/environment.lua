local M = {}

function M.is_mac()
  return vim.fn.has("mac") == 1
end

function M.is_unix()
  return vim.fn.has("unix") == 1
end

function M.is_win()
  return vim.fn.has("win32") == 1
end

function M.is_wsl()
  return vim.fn.has("wsl") == 1
end

function M.setup()
  local root = vim.fn.resolve(vim.fn.resolve(vim.fn.stdpath("config")) .. "/..")
  local plst = {}
  local pstr = ""

  if M.is_win() then
    vim.g.python3_host_prog = "python"
    plst = vim.fn.globpath(root, "/bin/windows/*", false, true)
  else
    vim.g.python3_host_prog = "python3"
    plst = vim.fn.globpath(root, "/bin/linux/*", false, true)
  end

  if plst then
    pstr = table.concat(plst, ";")
    vim.env.PATH = pstr .. ";" .. vim.env.PATH
  end
end

return M
