local M = {}

function M.setup(handlers)
  local Env = require("environment")

  local fwd_exec = nil
  local fwd_args = {}

  if Env.is_unix() then
    fwd_exec = "okular"
  elseif Env.is_win() then
    fwd_exec = "SumatraPDF"
  end

  if Env.is_unix() then
    fwd_args = {"--unique", "file:%p#src:%l%f"}
  elseif Env.is_win() then
    fwd_args = {"-reuse-instance", "%p", "-forward-search", "%f", "%l"}
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
            "-pdflatex",
            "%f",
          },
          onSave = true,
        },
        auxDirectory = "build",
        forwardSearch = {
          executable = fwd_exec,
          args = fwd_args,
        },
      },
    },
    handlers = handlers,
  })

  vim.keymap.set("n", "<Leader>lb", "<Cmd>TexlabBuild<CR>", {noremap = true})
  vim.keymap.set("n", "<Leader>lf", "<Cmd>TexlabForward<CR>", {noremap = true})
end

return M
