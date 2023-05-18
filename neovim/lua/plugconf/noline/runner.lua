local M = {}

local Highlight = require("noline.utility.highlight")

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
        Highlight.link("NRunner", "NRunnerR")
        msg = "🤔"
      elseif status == "success" then
        if interrupted then
          Highlight.link("NRunner", "NRunnerI")
          msg = "😑"
        else
          interrupted = false
          Highlight.link("NRunner", "NRunnerS")
          msg = "😎"
        end
      elseif status == "failure" then
        if interrupted then
          Highlight.link("NRunner", "NRunnerI")
          msg = "😑"
        else
          interrupted = false
          Highlight.link("NRunner", "NRunnerF")
          msg = "🤯"
        end
      end
    end
  end

  return msg
end

return M
