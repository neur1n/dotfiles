local M = {}

local Notify = require("notify")

local notify_id = nil

function M.re_notify(title, message, level)
  notify_id = Notify.notify(message, level, {
    ["title"] = title,
    ["on_close"] = (function () notify_id = nil end),
    ["replace"] = notify_id
  })
end

function M.setup()
  Notify.setup({
    stages = "slide"
  })
end

return M
