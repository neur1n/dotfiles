local M = {}

local Flash = require("flash")

local function Format(opts)
  return {
    {opts.match.first, "FlashMatch"},
    {opts.match.second, "FlashLabel"},
  }
end

function M.HopWord(onlyfwd)
  Flash.jump({
    search = {forward = onlyfwd, mode = "search", multi_window = false, wrap = false},
    label = {after = false, before = {0, 0}, uppercase = false, format = Format},
    pattern = [[\<]],
    action = function(match, state)
      state:hide()
      Flash.jump({
        search = {max_length = 0},
        highlight = {matches = false},
        label = {format = Format},
        matcher = function(win)
          return vim.tbl_filter(function(m)
            return m.label == match.label and m.win == win
          end, state.results)
        end,
        labeler = function(matches)
          for _, m in ipairs(matches) do
            m.label = m.second
          end
        end,
      })
    end,
    labeler = function(matches, state)
      local labels = state:labels()
      for m, match in ipairs(matches) do
        match.first = labels[math.floor((m - 1) / #labels) + 1]
        match.second = labels[(m - 1) % #labels + 1]
        match.label = match.first
      end
    end,
  })
end

return M
