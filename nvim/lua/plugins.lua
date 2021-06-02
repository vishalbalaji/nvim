---@diagnostic disable: undefined-global
local cmd = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
  cmd "packadd packer.nvim"
end

-- Only required if you have packer configured as `opt`
cmd [[packadd packer.nvim]]
-- Recompile packages on save
cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

-- PLUGINS
return require("packer").startup(
  function()
    -- Packer
    use "wbthomason/packer.nvim"

    -- General utils
    use "morhetz/gruvbox"
    use "windwp/nvim-autopairs"
    use "terrortylor/nvim-comment"
    use "kyazdani42/nvim-web-devicons"
    use "markonm/traces.vim"
    use "matze/vim-move"
    use "unblevable/quick-scope"
    use "junegunn/goyo.vim"
    use "vimlab/split-term.vim"
    use "nvim-lua/popup.nvim"
    use "nvim-telescope/telescope.nvim"
    use "mbbill/undotree"
    use "roxma/vim-tmux-clipboard"
    use "tmux-plugins/vim-tmux-focus-events"
    use "kovetskiy/sxhkd-vim"
    use "mg979/vim-visual-multi"
    use "junegunn/vim-easy-align"
    use "bkad/CamelCaseMotion"
    use "dkarter/bullets.vim"
    use "dhruvasagar/vim-table-mode"
    use "liuchengxu/vim-which-key"
    use "vim-pandoc/vim-pandoc-syntax"
    use "kevinhwang91/nvim-bqf"
    use "kyazdani42/nvim-tree.lua"
    use "jremmen/vim-ripgrep"
    use "norcalli/nvim-colorizer.lua"
    use {"lukas-reineke/indent-blankline.nvim", branch = "lua"}
    use "mattn/emmet-vim"
    use "ncm2/float-preview.nvim"
    use "jrudess/vim-foldtext"

    -- Bar/Statusline
    use "romgrk/barbar.nvim"
    use {
      "glepnir/galaxyline.nvim",
      branch = "main",
      requires = {"kyazdani42/nvim-web-devicons"}
    }

    -- Git
    use {
      "lewis6991/gitsigns.nvim",
      requires = {
        "nvim-lua/plenary.nvim"
      }
    }
    use "tpope/vim-fugitive"

    -- Treesitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use "nvim-treesitter/playground"
    use "p00f/nvim-ts-rainbow"

    -- LSP
    use "neovim/nvim-lspconfig"
    use "glepnir/lspsaga.nvim"
    use "kabouzeid/nvim-lspinstall"
    use "onsails/lspkind-nvim"
    use {
      "folke/lsp-trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {}
      end
    }

    -- Completion
    use "hrsh7th/nvim-compe"
    use "SirVer/ultisnips"
    use "honza/vim-snippets"
    use {"tzachar/compe-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-compe"}
  end
)
