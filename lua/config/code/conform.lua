return {
	"stevearc/conform.nvim",
	dependencies = {
		require("config.code.mason"),
		"zapling/mason-conform.nvim",
	},
	cmd = "ConformInfo",
	keys = {
		{ "<leader>lf", mode = { "n", "v" }, desc = "[L]SP: [F]ormat" },
	},

	---@type conform.setupOpts
	opts = {
		-- LazyVim will use these options when formatting with the conform.nvim formatter
		format = {
			timeout_ms = 3000,
			async = false, -- not recommended to change
			quiet = false, -- not recommended to change
		},

		formatters_by_ft = {
			-- The options you set here will be merged with the builtin formatters.
			-- You can also define any custom formatters here.

			lua = { "stylua" },

			json = { "jq" },

			[{
				"sh",
				"zsh",
			}] = { "shfmt" },

			[{
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"astro",
				"svelte",
			}] = {
				{
					"prettierd",
					-- eslint_d
				},
			},
		},

		formatters = {
			-- # Example of using dprint only when a dprint.json file is present
			-- dprint = {
			--   condition = function(ctx)
			--     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
			--   end,
			-- },
			--
			-- # Example of using shfmt with extra args
			shfmt = {
				prepend_args = { "-i", "2", "-ci" },
			},

			injected = { options = { ignore_errors = true } },

			eslint_d = {
				condition = function(ctx)
					---@diagnostic disable-next-line: return-type-mismatch, undefined-field
					return vim.fs.find(Config.lsp.utils.eslint_config_names, { path = ctx.filename, upward = true })[1]
				end,
			},

			prettierd = {
				condition = function(ctx)
					---@diagnostic disable-next-line: return-type-mismatch, undefined-field
					return vim.fs.find(Config.lsp.utils.prettier_config_names, { path = ctx.filename, upward = true })[1]
				end,
			},
		},
	},

	config = function(_, opts)
		local formatters_by_ft = opts.formatters_by_ft

		opts.formatters_by_ft = {}
		for fts, value in pairs(formatters_by_ft) do
			if type(fts) == "table" then
				for _, ft in pairs(fts) do
					opts.formatters_by_ft[ft] = value
				end
			else
				opts.formatters_by_ft[fts] = value
			end
		end

		local conform = require("conform")
		conform.setup(opts)

		vim.keymap.set({ "n", "v" }, "<leader>lf", function()
			conform.format({ lsp_format = "fallback" })
		end)

		require("mason-conform").setup({})
	end,
}
