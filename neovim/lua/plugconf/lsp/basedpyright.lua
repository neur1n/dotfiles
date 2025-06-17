local M = {}

function M.setup()
  vim.lsp.config("basedpyright", {
    settings = {
      basedpyright = {
        analysis = {
          typeCheckingMode = "standard",
          -- diagnosticSeverityOverrides = {
          --   reportAny = false,
          --   reportGeneralTypeIssues = false,
          --   reportMissingParameterType = false,
          --   reportMissingTypeStubs = false,
          --   reportUnknownParameterType = false,
          --   -- reportUnusedClass = "unused",
          --   -- reportUnusedFunction = "unused",
          --   -- reportUnusedImport = "unused",
          --   -- reportUnusedParameter = "unused",
          --   -- reportUnusedVariable = "unused",
          -- }
        }
      }
    },
  })

  vim.lsp.enable("basedpyright")
end

return M
