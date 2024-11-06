local M = {}

function M.setup(handlers)
  require("lspconfig").basedpyright.setup({
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
    handlers = handlers,
  })
end

return M
