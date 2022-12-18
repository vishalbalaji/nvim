local function plugins(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Colors
	use("marko-cerovac/material.nvim")

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		-- or                            , branch = "0.1.x",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- Treesitter
	use({
		{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
		{ "p00f/nvim-ts-rainbow" },
	})

	-- LSP
	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-emoji" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },

			-- NullLS
			{ "jose-elias-alvarez/null-ls.nvim" },

			-- Trouble
			{ "folke/trouble.nvim" },
		},
	})

	-- Tabline and Statusline
	use({
		"noib3/cokeline.nvim",
		requires = "kyazdani42/nvim-web-devicons", -- If you want devicons
	})
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- Filetree
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	})

	-- General
	use("mbbill/undotree")
	use("mrjones2014/smart-splits.nvim")
	use({
		"milisims/foldhue.nvim",
		config = function()
			require("foldhue").enable()
		end,
	})
	use({
		"anuvyklack/pretty-fold.nvim",
		config = function()
			require("pretty-fold").setup()
		end,
	})
	use({
		"booperlv/nvim-gomove",
		config = function()
			require("gomove").setup({
				map_defaults = false,
			})
		end,
	})
	use({
		"folke/noice.nvim",
		requires = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
		},
	})
	use({ "lukas-reineke/indent-blankline.nvim" })
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				-- pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
				ignore = "^$",
				mappings = {
					basic = false,
					extra = false,
				},
			})
			vim.keymap.set("n", "<C-/>", "<Plug>(comment_toggle_linewise_current)", { silent = true, noremap = true })
			vim.keymap.set("v", "<C-/>", "<Plug>(comment_toggle_linewise_visual)gv", { silent = true, noremap = true })
		end,
	})
	use({
		{ "echasnovski/mini.pairs", branch = "stable" },
		{ "echasnovski/mini.surround", branch = "stable" },
		{ "echasnovski/mini.cursorword", branch = "stable" },
	})
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				preview_config = { border = "rounded" },
			})
		end,
		-- tag = "release" -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
	})
	use({
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				input = {
					win_options = {
						winblend = 0,
					},
					insert_only = false,
				},
			})
		end,
	})
	use({
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				filetypes = { nil },
				user_default_options = {
					tailwind = true,
					RRGGBBAA = true, -- #RRGGBBAA hex codes
					AARRGGBB = true, -- 0xAARRGGBB hex codes
					rgb_fn = true, -- CSS rgb() and rgba() functions
					hsl_fn = true, -- CSS hsl() and hsla() functions
					css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
					css_fn = true,
				},
			})

			vim.keymap.set("n", "<leader>c", vim.cmd.ColorizerToggle, { silent = true, noremap = true })
		end,
	})
	use({
		"unblevable/quick-scope",
		config = function()
			vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
		end,
	})
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup()
		end,
	})
end

local function packer_setup(plugins_cb)
	local packer = require("packer")
	local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	local is_bootstrap = false

	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		is_bootstrap = true
		vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
		vim.cmd([[packadd packer.nvim]])
	end

	packer.init({
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	})
	packer.startup(function(use)
		plugins_cb(use)
		if is_bootstrap then
			require("packer").sync()
		end
	end)

	-- When we are bootstrapping a configuration, it doesn"t
	-- make sense to execute the rest of the init.lua.
	--
	-- You"ll need to restart nvim, and then it will work.
	if is_bootstrap then
		print("==================================")
		print("    Plugins are being installed")
		print("    Wait until Packer completes,")
		print("       then restart nvim")
		print("==================================")
		return
	end

	---@diagnostic disable-next-line: undefined-field
	local plugins_file = _G.getPath(vim.env.MYVIMRC) .. "lua/user/plugins.lua"

	-- Automatically source and re-compile packer whenever you save this init.lua
	local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
	vim.api.nvim_create_autocmd("BufWritePost", {
		command = 'source <afile> | echo "Packer: Compiled Plugins" | PackerCompile',
		group = packer_group,
		pattern = plugins_file,
	})

	vim.keymap.set("n", "<leader>pi", vim.cmd.PackerInstall, { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>pr", vim.cmd.PackerClean, { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>ps", vim.cmd.PackerSync, { silent = true, noremap = true })
end

packer_setup(plugins)
