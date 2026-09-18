local M = {}

local menu = {
  {
    label = "Nushell",
    args = {"nu"}
  },
  {
    label = "WSL",
    args = {"wsl"}
  },
}

function M.get()
  return menu
end

return M
