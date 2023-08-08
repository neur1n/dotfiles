local M = {}

function M.split4(pane)
  local p2 = pane:split{direction = "Right"}
  local p3 = pane:split{direction = "Bottom"}
  local p4 = p2:split{direction = "Bottom"}

  return {pane, p2, p3, p4}
end

return M
