local M = {}

function M.setup()
  require("lspconfig").lua_ls.setup({
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        }
      }
    }
  })
end

return M
