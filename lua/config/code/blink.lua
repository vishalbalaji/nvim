return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = {
		"rafamadriz/friendly-snippets",
		"moyiz/blink-emoji.nvim",
		{ "saghen/blink.compat", lazy = true, verison = false },
	},

	-- use a release tag to download pre-built binaries
	version = "*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- See the full "keymap" documentation for information on defining your own keymap.
		keymap = {
			preset = "enter",

			["<Tab>"] = {},
			["<S-Tab>"] = {},

			["<CR>"] = { "accept", "fallback" },
			["<C-y>"] = { "accept", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-l>"] = { "snippet_forward", "fallback" },
			["<C-h>"] = { "snippet_backward", "fallback" },
		},

		cmdline = {
			keymap = {
				["<CR>"] = {},
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
			},
		},

		appearance = {
			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
			-- Useful for when your theme doesn't support blink.cmp
			-- Will be removed in a future release
			use_nvim_cmp_as_default = true,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "emoji", "obsidian", "obsidian_new", "obsidian_tags" },
			providers = {
				emoji = {
					module = "blink-emoji",
					name = "Emoji",
					score_offset = 15, -- Tune by preference
					opts = { insert = false }, -- Insert emoji (default) or complete its name
				},
				obsidian = { name = "obsidian", module = "blink.compat.source" },
				obsidian_new = { name = "obsidian_new", module = "blink.compat.source" },
				obsidian_tags = { name = "obsidian_tags", module = "blink.compat.source" },
			},
		},

		completion = {
			list = { selection = { preselect = false, auto_insert = true } },
			ghost_text = { enabled = true },
			menu = {
				draw = {
					treesitter = { "lsp" },
					columns = {
						{ "kind_icon", gap = 1 },
						{ "label", "label_description", gap = 1 },
						{ "kind" },
					},
				},
			},
		},

		signature = { enabled = true },
	},
	opts_extend = { "sources.default" },
}
