return {
  {
    "stevearc/conform.nvim",
    config = function()
      require "configs.conform"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      filters = {
        git_ignored = false,
      },
      git = { enable = true },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function ()
      local opts = require("nvchad.configs.treesitter")
      local overrides = require "configs.treesitter"
      opts.ensure_installed = overrides.ensure_installed
      return opts
    end,
    dependencies = {
      'vrischmann/tree-sitter-templ',
    }
  },

  {
    "williamboman/mason.nvim",
    opts = function ()
      return require "configs.mason"
    end,
  },
    -- In order to modify the `lspconfig` configuration:
  {
    "neovim/nvim-lspconfig",
     config = function()
        require("nvchad.configs.lspconfig").defaults()
        require "configs.lspconfig"
     end,
  },

  {
    "nvimtools/none-ls.nvim",
    ft = { "go", "python", "templ", "javascriptreact", "typescriptreact", "javascript", "typescript" },
    opts =  function()
      local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
      return require("configs.none-ls").get_language_config(filetype)
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    ft = { "javascriptreact", "typescriptreact","html","templ"},
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "tpope/vim-fugitive",
    lazy = false
  },
  {
    "ruanyl/vim-gh-line",
    lazy = false
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  }
}
