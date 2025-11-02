local M = {}

local plugin = {
  {
    "skywind3000/asynctasks.vim",
    lazy = true,
    keys = require("plugconf.asynctasks").keymap,
    config = require("plugconf.asynctasks").setup,
    dependencies = {
      "skywind3000/asyncrun.vim",
    },
  },
  {
    "m4xshen/autoclose.nvim",
    lazy = true,
    event = "VeryLazy",
    config = require("plugconf.autoclose").setup,
  },
  {
    "nvim-focus/focus.nvim",
    lazy = true,
    cmd = {
      "FocusEnable",
      "FocusToggle",
    },
    config = require("plugconf.focus").setup,
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = "VeryLazy",
    config = require("plugconf.gitsigns").setup,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    cmd = {
      "IBLEnable",
      "IBLEnableScope",
      "IBLToggle",
      "IBLToggleScope",
    },
    config = require("plugconf.indent-blankline").setup,
  },
  {
    "ggandor/leap.nvim",
    lazy = true,
    keys = require("plugconf.leap").keymap,
    config = require("plugconf.leap").setup,
  },
  {
    "NvChad/nvim-colorizer.lua",
    lazy = true,
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerToggle",
    },
    config = require("plugconf.nvim-colorizer").setup,
  },
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    keys = require("plugconf.nvim-dap").keymap,
    config = require("plugconf.nvim-dap").setup,
  },
  {
    "kylechui/nvim-surround",
    lazy = true,
    event = "VeryLazy",
    config = require("plugconf.nvim-surround").setup,
  },
  {
    "nguyenvukhang/nvim-toggler",
    lazy = true,
    keys = require("plugconf.nvim-toggler").keymap,
    config = require("plugconf.nvim-toggler").setup,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = true,
    event = "VeryLazy",
    cmd = {
      "TSInstall",
      "TSUninstall",
      "TSUpdate",
    },
    config = require("plugconf.nvim-treesitter").setup,
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    keys = require("plugconf.telescope").keymap,
    config = require("plugconf.telescope").setup,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "gbirke/telescope-foldmarkers.nvim",
        lazy = true,
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = true,
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
    },
  },
  {
    "junegunn/vim-easy-align",
    lazy = true,
    keys = require("plugconf.vim-easy-align").keymap,
  },
  {
    "matze/vim-move",
    lazy = true,
    event = "VeryLazy",
  },
  {
    "mg979/vim-visual-multi",
    lazy = true,
    event = "VeryLazy",
    init = require("plugconf.vim-visual-multi").setup,
  },
  {
    "sindrets/winshift.nvim",
    lazy = true,
    keys = require("plugconf.winshift").keymap,
    config = require("plugconf.winshift").setup,
  },
  {
    "folke/zen-mode.nvim",
    lazy = true,
    keys = require("plugconf.zen-mode").keymap,
    config = require("plugconf.zen-mode").setup,
  },

  -- Completion
  {
    "Saghen/blink.cmp",
    version = "1.*",
    event = "VeryLazy",
    config = require("plugconf.blink-cmp").setup,
    dependencies = {
      "neovim/nvim-lspconfig",
      config = require("plugconf.nvim-lspconfig").setup,
    },
  },
  {
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
    config = require("plugconf.copilot").setup,
  },

  {
    "neur1n/neuims",
    lazy = true,
    cmd = {
      "IMSToggle",
    },
  },
  {
    "neur1n/noline.nvim",
    lazy = false,
    event = "ColorScheme *",
    config = require("plugconf.noline").setup
  },
}

function M.setup()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end

  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup(plugin)
end

return M
