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

local function getPath(str, sep)
	sep = sep or "/"
	return str:match("(.*" .. sep .. ")")
end

local packerGroup = vim.api.nvim_create_augroup("Packer", { clear = true })
local plugins_file = getPath(vim.env.MYVIMRC) .. "lua/user/plugins/init.lua"

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = plugins_file,
	command = "echo 'Packer: Compiling Plugins' | source <afile> | PackerCompile",
	group = packerGroup,
})

packer.startup(function(use)
	-- Packer
	use("wbthomason/packer.nvim")

	-- ColorScheme
	use({ "NTBBloodbath/doom-one.nvim" })

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
	use("NvChad/nvim-colorizer.lua")
	use("p00f/nvim-ts-rainbow")

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
			require("fidget").setup({
				window = {
					blend = 0,
				},
			})
		end,
	})
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				keywords = {
					CREDIT = { icon = "☺ ", color = "info", alt = { "THANKS" } },
					TODO = { color = "warning" },
				},
			})
		end,
	})
	use("stevearc/dressing.nvim")
	use("lvimuser/lsp-inlayhints.nvim")
	use("b0o/schemastore.nvim")

	-- -- CMP
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("hrsh7th/cmp-emoji")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("jc-doyle/cmp-pandoc-references")
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("lukas-reineke/cmp-under-comparator")

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
	use("folke/which-key.nvim")
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
	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})
	use({
		"unblevable/quick-scope",
		config = function()
			vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
		end,
	})
	use("anuvyklack/pretty-fold.nvim")
	use({
		"milisims/foldhue.nvim",
		config = function()
			require("foldhue").enable()
		end,
	})
	use({
		"booperlv/nvim-gomove",
		config = function()
			require("gomove").setup({ map_defaults = false })
		end,
	})
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup({
				on_open = function(term)
					vim.api.nvim_buf_set_keymap(
						term.bufnr,
						"n",
						"q",
						"<cmd>Bdelete!<CR>",
						{ noremap = true, silent = true }
					)
				end,
				persist_mode = true,
				start_in_insert = false,
				shade_terminals = false,
			})
		end,
	})
	use({
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup({
				link_tree_to_folds = false,
				link_folds_to_tree = false,
				manage_folds = false,
				layout = {
					width = 0.2,
					max_width = { 30 },
				},
			})
			vim.api.nvim_set_keymap("n", "<Tab>", "za", { noremap = false, silent = true })
			vim.api.nvim_set_keymap("n", "<S-Tab>", "zA", { noremap = false, silent = true })
		end,
	})
	use({
		"folke/noice.nvim",
		event = "VimEnter",
		config = function()
			require("noice").setup({
				cmdline = {
					view = "cmdline",
				},
				popupmenu = {
					enabled = false, -- disable if you use something like cmp-cmdline
				},
			})
		end,
		requires = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				config = function()
					require("notify").setup({
						on_open = function(win)
							vim.api.nvim_win_set_config(win, { focusable = false })
						end,
						background_color = "#000000",
						max_width = 50,
						timeout = 1000,
						stages = "fade",
					})
				end,
			},
		},
	})

	-- -- Git
	use("tpope/vim-fugitive")
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({})
		end,
	})
	use({
		"akinsho/git-conflict.nvim",
		tag = "*",
		config = function()
			require("git-conflict").setup()
		end,
	})
	use("benknoble/gitignore-vim")

	-- -- Markdown
	use({
		"dkarter/bullets.vim",
		config = function()
			vim.g.bullets_enabled_file_types = require("user.autocommands").bullets_enabled_file_types
			vim.g.bullets_pad_right = 0
		end,
	})
	use({
		"AckslD/nvim-FeMaco.lua",
		config = 'require("femaco").setup()',
	})
	use({ "lukas-reineke/headlines.nvim" })
	-- use("davidgranstrom/nvim-markdown-previw")
end)
