local M = {}

function M.setup()
  local dap = require("dap")

  dap.adapters.python = function(cb, config)
    if config.request == "attach" then
      local port = (config.connect or config).port

      local host = (config.connect or config).host or "127.0.0.1"

      cb({
        type = "server",
        port = assert(port, "`connect.port` is required for a python `attach` configuration"),
        host = host,
        options = {
          source_filetype = "python",
        },
      })
    else
      cb({
        type = "executable",
        command = "python",
        args = {"-m", "debugpy.adapter"},
        options = {
          source_filetype = "python",
        },
      })
    end
  end

  dap.configurations.python = {
    {
      -- The first three options are required by nvim-dap
      type = "python"; -- the type here established the link to the adapter definition: `dap.adapters.python`
      request = "launch";
      name = "Launch file";

      -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
      program = "${file}"; -- This configuration will launch the current file if used.
      python = "python";
    },
  }
end

return M
