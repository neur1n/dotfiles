local M = {}

local State = require("plugconf.noline.state")

local decorators = {
  {["left"] = "",  ["right"] = "", ["sep"] = "│"},
  {["left"] = "",  ["right"] = "", ["sep"] = "│"},
  {["left"] = "",  ["right"] = "", ["sep"] = "│"},
  {["left"] = "",  ["right"] = "", ["sep"] = "│"},
  {["left"] = "",  ["right"] = "", ["sep"] = ""},
  {["left"] = "",  ["right"] = "", ["sep"] = ""},
  {["left"] = "",  ["right"] = "", ["sep"] = ""},
  {["left"] = "",  ["right"] = "", ["sep"] = ""},
}

function M.get()
  local group = {}

  if (not State.stl_initialized) or (not State.tal_initialized) then
    math.randomseed(os.time())
    group = decorators[math.random(#decorators)]
  end

  return group
end

return M
