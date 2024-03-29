local M = {
	"nvim-treesitter/nvim-treesitter",
	enabled = true,
	build = ":TSUpdate",
	event = "BufReadPost",
	dependencies = {
		{ "nvim-treesitter/playground",                  cmd = "TSPlaygroundToggle" },
		{ "nvim-treesitter/nvim-treesitter-context",     event = "VeryLazy" },
		{ "nvim-treesitter/nvim-treesitter-textobjects", event = "VeryLazy" },
		{ "gungun974/nvim-ts-autotag",                   event = "VeryLazy" },
		{
			"andymass/vim-matchup",
			event = "VeryLazy",
			init = function()
				vim.g.matchup_matchparen_offscreen = { method = "status" }
			end,
		},
	},
}

local function treesitter_hls()
	local c = require("config.plugins.colors")
	local hl = c.safe_hl
	local bg_alt = c.get_hex("NormalAlt", "bg")
	local comment_fg = c.get_hex("Comment", "fg")

	hl("TreesitterContext", { bg = bg_alt })
	hl("TreesitterContextBottom", { underline = true, fg = comment_fg })
end

M.config = function()
	local config = {}

	-- Base-Level Settings
	config.ensure_installed = { "c", "lua", "rust", "help", "javascript", "typescript", "vim" }
	config.sync_install = false
	config.auto_install = true

	-- TS Plugins
	config.highlight = {
		enable = true,
		disable = { "diff" },
		additional_vim_regex_highlighting = { "markdown" },
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
				["]f"] = "@function.outer",
				["]c"] = "@class.outer",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]C"] = "@class.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[c"] = "@class.outer",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[C"] = "@class.outer",
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
			node_decremental = "<c-s-space>",
		},
	}

	config.autotag = {
		enable = true,
		hlgroups = {
			"TSRainbowRed",
			"TSRainbowBlue",
			"TSRainbowCyan",
			"TSRainbowGreen",
			"TSRainbowOrange",
			"TSRainbowViolet",
			"TSRainbowYellow",
		},
	}

	config.matchup = {
		enable = true, -- mandatory, false will disable the whole extension
		disable_virtual_text = true,
	}

	config.ignore_install = { "help" }

	require("nvim-treesitter.configs").setup(config)
	require("treesitter-context").setup({
		enable = true,
		max_lines = 4,
	})
	treesitter_hls()
end

return M
