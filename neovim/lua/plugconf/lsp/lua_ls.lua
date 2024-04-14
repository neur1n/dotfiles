local M = {}

function M.setup(handlers)
  require("lspconfig").lua_ls.setup({
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        }
      }
    },
    handlers = handlers,
  })
end

return M
