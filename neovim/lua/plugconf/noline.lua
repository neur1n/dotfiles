local M = {}

function M.setup()
  local Stl = require("plugconf.noline.statusline")
  local Tal = require("plugconf.noline.tabline")
  local Runner = require("plugconf.noline.runner")

  vim.o.showtabline = 2

  local id = vim.api.nvim_create_augroup("n_noline", {clear = true})

  vim.api.nvim_create_autocmd({"BufEnter", "FileChangedShellPost", "FileType", "WinEnter"}, {
    group = id,
    pattern = "*",
    callback = Stl.update,
  })

  vim.api.nvim_create_autocmd("BufEnter", {
    group = id,
    pattern = "*",
    callback = Tal.update,
  })

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = id,
    pattern = "*",
    callback = function ()
      Stl.redraw()
      Tal.redraw()
    end
  })

  vim.api.nvim_create_autocmd("User", {
    group = id,
    pattern = "AsyncRunInterrupt",
    callback = Runner.interrupt,
  })

  Stl.redraw()
  Tal.redraw()
end

return M
