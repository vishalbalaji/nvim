-- CREDIT: http://www.lazyvim.org/plugins/linting
return {
	"mfussenegger/nvim-lint",
	event = "LazyFile",
	dependencies = {
		require("config.code.mason"),
		"rshkarin/mason-nvim-lint",
	},
	opts = {
		-- Event to trigger linters
		events = { "BufWritePost", "BufReadPost", "TextChanged", "TextChangedI" },
		linters_by_ft = {
			-- Use the "*" filetype to run linters on all filetypes.
			-- ['*'] = { 'global linter' },
			-- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
			-- ['_'] = { 'fallback linter' },
			-- ["*"] = { "typos" },

			-- [{
			-- 	"json",
			-- 	"jsonc",
			-- }] = { "jsonlint" },

			[{
				"sh",
				"zsh",
			}] = { "shellcheck" },

			-- [{
			-- 	"javascript",
			-- 	"javascriptreact",
			-- 	"typescript",
			-- 	"typescriptreact",
			-- 	"astro",
			-- 	"svelte",
			-- }] = {
			-- 	"eslint_d",
			-- },
		},
		-- or add custom linters.
		---@type table<string,table>
		linters = {
			-- -- Example of using selene only when a selene.toml file is present
			-- selene = {
			--   -- `condition` is another LazyVim extension that allows you to
			--   -- dynamically enable/disable linters based on the context.
			--   condition = function(ctx)
			--     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
			--   end,
			-- },

			shellcheck = {
				condition = function(ctx)
					return vim.fs.basename(ctx.filename) ~= ".env"
				end,
			},

			eslint_d = {
				condition = function(ctx)
					return vim.fs.find(Config.lsp.utils.eslint_config_names, { path = ctx.filename, upward = true })[1]
				end,
			},
		},
	},
	config = function(_, opts)
		local N = {}

		local lint = require("lint")
		for name, linter in pairs(opts.linters) do
			if type(linter) == "table" and type(lint.linters[name]) == "table" then
				---@diagnostic disable-next-line: param-type-mismatch
				lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
				if type(linter.prepend_args) == "table" then
					vim.list_extend(lint.linters[name].args, linter.prepend_args)
				end
			else
				lint.linters[name] = linter
			end
		end

		lint.linters_by_ft = {}
		for fts, value in pairs(opts.linters_by_ft) do
			if type(fts) == "table" then
				for _, ft in pairs(fts) do
					lint.linters_by_ft[ft] = value
				end
			else
				lint.linters_by_ft[fts] = value
			end
		end

		function N.debounce(ms, fn)
			local timer = vim.uv.new_timer()
			return function(...)
				local argv = { ... }
				timer:start(ms, 0, function()
					timer:stop()
					vim.schedule_wrap(fn)(unpack(argv))
				end)
			end
		end

		function N.lint()
			-- Use nvim-lint's logic first:
			-- * checks if linters exist for the full filetype first
			-- * otherwise will split filetype by "." and add all those linters
			-- * this differs from conform.nvim which only uses the first filetype that has a formatter
			local names = lint._resolve_linter_by_ft(vim.bo.filetype)

			-- Create a copy of the names table to avoid modifying the original.
			names = vim.list_extend({}, names)

			-- Add fallback linters.
			if #names == 0 then
				vim.list_extend(names, lint.linters_by_ft["_"] or {})
			end

			-- Add global linters.
			vim.list_extend(names, lint.linters_by_ft["*"] or {})

			-- Filter out linters that don't exist or don't match the condition.
			local ctx = { filename = vim.api.nvim_buf_get_name(0) }
			ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
			names = vim.tbl_filter(function(name)
				local linter = lint.linters[name]
				if not linter then
					vim.health.warn("Linter not found: " .. name, { title = "nvim-lint" })
				end
				---@diagnostic disable-next-line: undefined-field
				return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
			end, names)

			-- Run linters.
			if #names > 0 then
				lint.try_lint(names)
			end
		end

		vim.api.nvim_create_autocmd(opts.events, {
			group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
			callback = N.debounce(100, N.lint),
		})

		require("mason-nvim-lint").setup({
			automatic_installation = false,
		})
	end,
}
