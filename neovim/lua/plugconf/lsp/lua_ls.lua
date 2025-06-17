local M = {}

function M.setup()
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        }
      }
    },
  })

  vim.lsp.enable("lua_ls")
end

return M
