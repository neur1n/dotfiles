local M = {}

local interrupted = false

function M.interrupt()
  interrupted = true
end

function M.status()
  local msg = ""

  if vim.fn.exists(":AsyncRun") then
    local status = vim.g.asyncrun_status

    if status ~= nil then
      if status == "running" then
        interrupted = false
        msg = "🤔"
      elseif status == "success" then
        if interrupted then
          msg = "😑"
        else
          interrupted = false
          msg = "😎"
        end
      elseif status == "failure" then
        if interrupted then
          msg = "😑"
        else
          interrupted = false
          msg = "🤯"
        end
      end
    end
  end

  return msg
end

return M
