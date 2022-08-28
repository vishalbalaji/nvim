local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

local packerGroup = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile",
  group = packerGroup,
})

packer.startup(function(use)
  -- Packer
  use("wbthomason/packer.nvim")

  -- ColorScheme
  use("NTBBloodbath/doom-one.nvim")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("nvim-treesitter/playground")
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("haringsrob/nvim_context_vt")
  use({
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  })

  -- LSP and Diagnostics
  use("neovim/nvim-lspconfig")
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("ray-x/lsp_signature.nvim")
  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        signs = {
          -- icons / text used for a diagnostic
          error = "",
          warning = "",
          hint = "",
          information = "",
          other = "",
        },
      })
    end,
  })
  use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({})
    end,
  })
  use("stevearc/dressing.nvim")

  -- -- CMP
  use("hrsh7th/cmp-buffer") -- buffer completions
  use("hrsh7th/cmp-cmdline") -- cmdline completions
  use("hrsh7th/cmp-emoji")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-path") -- path completions
  use("hrsh7th/nvim-cmp") -- The completion plugin
  use("jc-doyle/cmp-pandoc-references")
  use("saadparwaiz1/cmp_luasnip") -- snippet completions

  -- -- -- Snippets
  use("L3MON4D3/LuaSnip") --snippet engine
  use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

  -- General
  use({
    "ethanholz/nvim-lastplace",
    config = function()
      require("nvim-lastplace").setup({})
    end,
  })
  use("lewis6991/impatient.nvim")
  use({
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icons
    },
    tag = "nightly", -- optional, updated every week. (see issue #1193)
  })
  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    -- or                            , branch = '0.1.x',
    requires = { { "nvim-lua/plenary.nvim" } },
  })
  use({
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({
        triggers = { "<leader>" }, -- or specify a list manually
      })
    end,
  })
  use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })
  use("famiu/bufdelete.nvim")
  use({
    "kwkarlwang/bufresize.nvim",
    config = function()
      require("bufresize").setup({
        register = {
          keys = {},
          trigger_events = { "BufWinEnter", "WinEnter" },
        },
        resize = {
          keys = {},
          trigger_events = { "VimResized" },
          increment = 5,
        },
      })
    end,
  })
  use({
    "mrjones2014/smart-splits.nvim",
    config = function()
      require("smart-splits").setup({
        -- Ignored filetypes (only while resizing)
        ignored_filetypes = {
          "nofile",
          "quickfix",
          "prompt",
        },
        -- Ignored buffer types (only while resizing)
        ignored_buftypes = { "NvimTree" },
        resize_mode = {
          hooks = {
            on_leave = require("bufresize").register,
          },
        },
      })
    end,
  })
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })
  use({
    "noib3/nvim-cokeline",
    requires = "kyazdani42/nvim-web-devicons", -- If you want devicons
  })
  use("mg979/vim-visual-multi")
  use({ "fgheng/winbar.nvim" })
  use({
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
  })
  use("kevinhwang91/nvim-bqf")
  use("lukas-reineke/indent-blankline.nvim")
  use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight

  -- -- Git
  use("tpope/vim-fugitive")
  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({})
    end,
  })
end)
