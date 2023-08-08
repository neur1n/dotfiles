local M = {}

local function split2(pane)
  local p2 = pane:split{direction = "Right"}
  return {pane, p2}
end

local function split4(pane)
  local p2 = pane:split{direction = "Right"}
  local p3 = pane:split{direction = "Bottom"}
  local p4 = p2:split{direction = "Bottom"}

  return {pane, p2, p3, p4}
end

function M.split(pane, count)
  if count == "2" then
    return split2(pane)
  elseif count == "4" then
    return split4(pane)
  end

  return {pane}
end

return M
