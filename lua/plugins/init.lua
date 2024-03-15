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
      return require "configs.treesitter"
    end,
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
    ft = { "go", "python" },
    opts =  function()
      local filetype = vim.api.nvim_buf_get_option(0, 'filetype') -- get the current file type
      if filetype == 'go' then
        return require"configs.none-ls-go"
      elseif filetype == "python" then
        return require"configs.none-ls-python"
      else
        return {}
      end
    end,
  },
}
