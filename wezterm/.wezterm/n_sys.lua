local M = {}

function M.os()
  return package.config:sub(1, 1) == "/" and "unix" or "win"
end

return M
