local IO = require("io")

local M = {}

function M.get_line(path)
  local file = IO.open(path, "rb")

  if file ~= nil then
    return file:read()
  else
    return nil
  end
end

return M
