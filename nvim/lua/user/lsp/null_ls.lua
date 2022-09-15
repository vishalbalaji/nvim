local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

local sources = {
	-- General
	-- null_ls.builtins.code_actions.refactoring,
	null_ls.builtins.code_actions.gitsigns,
	null_ls.builtins.completion.spell.with({ filetypes = { "markdown", "latex" } }),
	null_ls.builtins.formatting.cbfmt,
	null_ls.builtins.formatting.yamlfmt,

	-- Lua
	null_ls.builtins.formatting.stylua,

	-- Shell
	null_ls.builtins.diagnostics.shellcheck,
	null_ls.builtins.formatting.shfmt,

	-- TS/JS
	null_ls.builtins.code_actions.eslint_d.with({
		condition = function(utils)
			return utils.root_has_file({ ".eslintrc", ".eslintrc.js", ".eslintrc.cjs" })
		end,
	}),
	null_ls.builtins.diagnostics.eslint_d.with({
		condition = function(utils)
			return utils.root_has_file({ ".eslintrc", ".eslintrc.js", ".eslintrc.cjs" })
		end,
	}),
	null_ls.builtins.formatting.eslint_d.with({
		condition = function(utils)
			return utils.root_has_file({ ".eslintrc", ".eslintrc.js", ".eslintrc.cjs" })
		end,
	}),
}

null_ls.setup({ sources = sources })
