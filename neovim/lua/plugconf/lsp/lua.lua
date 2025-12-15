local M = {}

function M.setup()
  if vim.fn.executable("lua-language-server") then
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
end

return M
