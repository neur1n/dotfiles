local M = {}

local plugins ={
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
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = "ColorScheme *",
    config = require("plugconf.gitsigns").setup,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    cmd = {
      "IBLEnable",
      "IBLDisable",
      "IBLToggle",
      "IBLEnableScope",
      "IBLDisableScope",
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
    "windwp/nvim-autopairs",
    lazy = true,
    event = "InsertEnter",
    config = require("plugconf.nvim-autopairs").setup,
  },
  {
    "LhKipp/nvim-nu",
    lazy = true,
    event = "FileType nu",
    config = require("plugconf.nvim-nu").setup,
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
    lazy = true,
    event = "BufReadPost",
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
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = true,
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
    },
  },
  {
    "tpope/vim-commentary",
    lazy = false,
    event = "VeryLazy",
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
    keys = {
      {"<Leader>zm", "<Cmd>ZenMode<CR>", mode = "n", {noremap = true}}
    },
    config = require("plugconf.zen-mode").setup,
  },

  -- Completion
  {
    "github/copilot.vim",
     config = require("plugconf.copilot").setup,
  },
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = "ColorScheme *",
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        config = require("plugconf.nvim-lspconfig").setup,
      },
      {
        "hrsh7th/vim-vsnip",
        config = require("plugconf.vim-vsnip").setup,
      },
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-vsnip",
    },
    config = require("plugconf.nvim-cmp").setup,
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
    lazy = true,
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

  require("lazy").setup(plugins)
end

return M
