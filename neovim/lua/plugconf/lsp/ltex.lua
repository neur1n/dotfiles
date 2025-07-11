local M = {}

local function local_dict()
  local cwd = vim.fn.getcwd()

  local dict = io.open(cwd .. "/ltex.dict", "r")
  if dict == nil then
    return nil
  end

  local words = {}
  for line in dict:lines() do
    table.insert(words, line)
  end

  dict:close()

  return words
end

function M.setup()
  vim.lsp.config("ltex", {
    settings = {
      ltex = {
        dictionary = {["en-US"] = local_dict()},
        language = "en-US",
      },
    },
  })

  vim.lsp.enable("ltex")
end

return M
