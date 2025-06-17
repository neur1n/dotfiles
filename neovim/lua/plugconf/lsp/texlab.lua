local M = {}

function M.setup()
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

  vim.lsp.config("texlab", {
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
            vim.uv.fs_stat(".pdflatex") and "-pdflatex" or "-xelatex",
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
  })

  vim.lsp.enable("texlab")

  vim.keymap.set("n", "<Leader>tb", "<Cmd>LspTexlabBuild<CR>", {noremap = true})
  vim.keymap.set("n", "<Leader>tf", "<Cmd>LspTexlabForward<CR>", {noremap = true})
end

return M
