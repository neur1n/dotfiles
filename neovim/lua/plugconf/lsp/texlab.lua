local M = {}

function M.setup()
  local Env = require("environment")

  local fexec = nil
  local fargs = {}

  if Env.is_unix() then
    fexec = "okular"
  elseif Env.is_win() then
    fexec = "SumatraPDF"
  end

  if Env.is_unix() then
    fargs = {"--unique", "file:%p#src:%l%f"}
  elseif Env.is_win() then
    fargs = {"-reuse-instance", "%p", "-forward-search", "%f", "%l"}
  end

  require("lspconfig").texlab.setup({
    settings = {
      texlab = {
        build = {
          executable = "latexmk",
          args = {
            "-aux-directory=build",
            "-bibtex",
            "-f",
            "-file-line-error",
            "-interaction=nonstopmode",
            "-MSWinBackSlash-",
            "-output-directory=build",
            "-shell-escape",
            "-synctex=1",
            "-view=pdf",
            "-xelatex",
            "%f",
          },
          onSave = true,
        },
        auxDirectory = "build",
        forwardSearch = {
          executable = fexec,
          args = fargs,
        },
      },
    }
  })

  vim.keymap.set("n", "<Leader>lb", "<Cmd>TexlabBuild<CR>", {noremap = true})
  vim.keymap.set("n", "<Leader>lf", "<Cmd>TexlabForward<CR>", {noremap = true})
end

return M
