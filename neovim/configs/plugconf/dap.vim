scriptencoding utf-8

"***************************************************** mfussenegger/nvim-dap{{{
lua << EOF
local dap = require("dap")

dap.set_log_level("TRACE")

dap.adapters.cxx = {
  type = "executable";
  command = os.getenv("VIMCONFIG") .. "/dap/vscode-cpptools/bin/OpenDebugAD7.exe";
}

dap.adapters.python = {
  type = "executable";
  command = "python";
  args = {"-m", "debugpy.adapter"};
}

dap.adapters.nlua = function(callback, config)
  callback({type = "server", host = config.host, port = config.port})
end

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cxx",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = true,
  },
  {
    name = "Attach to gdbserver: 26789",
    type = "cxx",
    request = "launch",
    MIMode = "lldb",
    miDebuggerServerAddress = "localhost:26789",
    miDebuggerPath = "lldb",
    cwd = "${workspaceFolder}",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
  },
}

dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to running Neovim instance",
    host = function()
      local value = vim.fn.input("Host [127.0.0.1]: ")
      if value ~= "" then
        return value
      end
      return "127.0.0.1"
    end,
    port = function()
      local val = tonumber(vim.fn.input("Port: "))
      assert(val, "Please provide a port number")
      return val
    end,
  }
}

dap.configurations.python = {
  {
    type = "python";
    request = "launch";
    name = "Launch file";
    program = "${file}";
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable("python3") == 1 then
        return "python3"
      elseif vim.fn.executable("python2") == 1 then
        return "python2"
      else
        return "python"
      end
    end;
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
EOF

nnoremap <silent> <leader>ds :lua require'dap'.close()<CR>
nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>
nnoremap <silent> <leader>dv :lua require'dap'.step_over()<CR>
nnoremap <silent> <leader>di :lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>do :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
"}}}
