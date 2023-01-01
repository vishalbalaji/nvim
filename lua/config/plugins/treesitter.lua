local M = {
	"nvim-treesitter/nvim-treesitter",
	enabled = true,
	build = ":TSUpdate",
	event = "BufReadPost",
	dependencies = {
		{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
		{ "nvim-treesitter/nvim-treesitter-context", event = "VeryLazy" },
		{ "p00f/nvim-ts-rainbow", event = "VeryLazy" },
		{ "nvim-treesitter/nvim-treesitter-textobjects", event = "VeryLazy" },
		{ "windwp/nvim-ts-autotag", event = "VeryLazy" },
		{
			"andymass/vim-matchup",
			event = "VeryLazy",
			init = function()
				vim.g.matchup_matchparen_offscreen = { method = "status" }
			end,
		},
	},
}

M.init = function()
	local c = require("config.plugins.colors")
	local hl = c.safe_hl
	local bg_alt = c.get_hex("NormalAlt", "bg")
	local comment_fg = c.get_hex("Comment", "fg")

	hl("TreesitterContext", { bg = bg_alt })
	hl("TreesitterContextBottom", { underline = true, fg = comment_fg })
end

M.config = function()
	local config = {}
	local colors = require("config.plugins.colors").get_colors()

	-- Base-Level Settings
	config.ensure_installed = { "c", "lua", "rust", "help", "javascript", "typescript", "vim" }
	config.sync_install = false
	config.auto_install = true

	-- TS Plugins
	config.highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	}

	config.indent = {
		enable = true,
		disable = { "yaml", "python" },
	}

	config.textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	}

	config.incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<c-backspace>",
		},
	}

	config.rainbow = {
		enable = true,
		extended_mode = true,
		colors = {
			colors.red,
			colors.yellow,
			colors.green,
			colors.cyan,
			colors.blue,
			colors.magenta or colors.purple,
		},
		termcolors = {
			"Red",
			"Yellow",
			"Green",
			"Cyan",
			"Blue",
			"Magenta",
		},
	}

	config.autotag = {
		enable = true,
	}

	config.matchup = {
		enable = true, -- mandatory, false will disable the whole extension
		disable_virtual_text = true,
	}

	require("nvim-treesitter.configs").setup(config)
end

return M
