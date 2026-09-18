local Env = require("environment")

local fwd_exe = nil
local fwd_arg = {}

if Env.is_unix() then
  fwd_exe = "okular"
elseif Env.is_win() then
  fwd_exe = "SumatraPDF"
end

if Env.is_unix() then
  fwd_arg = {"--unique", "file:%p#src:%l%f"}
elseif Env.is_win() then
  fwd_arg = {"-reuse-instance", "%p", "-forward-search", "%f", "%l"}
end

return {
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
        executable = fwd_exe,
        args = fwd_arg,
      },
      diagnostics = {
        ignoredPatterns = {"Unused"},
      },
    },
  },
}
