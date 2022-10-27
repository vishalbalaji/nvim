local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

local home_dir = os.getenv("HOME")
local sources = {
	-- General
	-- null_ls.builtins.code_actions.refactoring,
	null_ls.builtins.code_actions.gitsigns,
	null_ls.builtins.completion.spell.with({ filetypes = { "markdown", "latex" } }),
	null_ls.builtins.formatting.cbfmt,
	null_ls.builtins.formatting.yamlfmt,
	null_ls.builtins.diagnostics.commitlint.with({
		extra_args = { "-g", home_dir .. "/.local/share/nvim/commitlint.config.js" },
	}),

	-- CSS
	null_ls.builtins.formatting.prettierd.with({
		filetypes = { "css", "json" },
	}),

	-- Lua
	null_ls.builtins.formatting.stylua,

	-- Shell
	null_ls.builtins.code_actions.shellcheck.with({
		extra_filetypes = { "zsh" },
	}),
	null_ls.builtins.diagnostics.shellcheck.with({
		extra_filetypes = { "zsh" },
		diagnostic_config = {
			update_in_insert = true,
		},
	}),
	null_ls.builtins.formatting.shfmt.with({
		extra_filetypes = { "zsh" },
	}),

	-- Python
	null_ls.builtins.formatting.black,
	null_ls.builtins.formatting.isort,

	-- TS/JS
	null_ls.builtins.code_actions.eslint_d.with({
		condition = function(utils)
			return utils.root_has_file({ ".eslintrc", ".eslintrc.json", ".eslintrc.js", ".eslintrc.cjs" })
		end,
	}),
	null_ls.builtins.diagnostics.eslint_d.with({
		condition = function(utils)
			return utils.root_has_file({ ".eslintrc", ".eslintrc.json", ".eslintrc.js", ".eslintrc.cjs" })
		end,
	}),
	null_ls.builtins.formatting.eslint_d.with({
		condition = function(utils)
			return utils.root_has_file({ ".eslintrc", ".eslintrc.json", ".eslintrc.js", ".eslintrc.cjs" })
		end,
	}),
}

null_ls.setup({ sources = sources })
