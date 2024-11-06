local M = {}

function M.keymap()
  return {
      {"<Leader>db", "<Cmd>lua require('dap').toggle_breakpoint()<CR>", mode = "n", {noremap = true, silent = true}},
      {"<Leader>dc", "<Cmd>lua require('dap').continue()<CR>", mode = "n", {noremap = true, silent = true}},
      {"<Leader>dr", "<Cmd>lua require('dap').repl.toggle({height = math.floor(vim.o.lines / 3)})<CR>", mode = "n", {noremap = true, silent = true}},
      {"<Leader>di", "<Cmd>lua require('dap').step_into()<CR>", mode = "n", {noremap = true, silent = true}},
      {"<Leader>do", "<Cmd>lua require('dap').step_out()<CR>", mode = "n", {noremap = true, silent = true}},
      {"<Leader>dv", "<Cmd>lua require('dap').step_over()<CR>", mode = "n", {noremap = true, silent = true}},
      {"<Leader>dt", "<Cmd>lua require('dap').terminate()<CR>", mode = "n", {noremap = true, silent = true}},
    }
end

function M.setup()
  require("dap").defaults.fallback.switchbuf = "usevisible,usetab,uselast"

  require("plugconf.dap.debugpy").setup()

  vim.fn.sign_define("DapBreakpoint", {text = "🚧"})
  vim.fn.sign_define("DapStopped", {text = "🛑"})
end

return M
