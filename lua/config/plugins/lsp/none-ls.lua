local M = {
	"nvimtools/none-ls.nvim",
	enabled = true,
	event = "VeryLazy",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"gbprod/none-ls-shellcheck.nvim",
	},
}

local null_ls_stop = function()
	local null_ls_client
	for _, client in ipairs(vim.lsp.get_clients()) do
		if client.name == "null-ls" then
			null_ls_client = client
		end
	end
	if not null_ls_client then
		return
	end

	null_ls_client.stop()
end

local null_ls_restart = function()
	local null_ls_client
	for _, client in ipairs(vim.lsp.get_clients()) do
		if client.name == "null-ls" then
			vim.cmd([[ NullLsToggle ]])
			vim.cmd([[ NullLsToggle ]])
		end
	end
	if not null_ls_client then
		return
	end

	null_ls_client.stop()
end

M.init = function()
	local map = require("config.keymaps")
	map("n", "<leader>ln", vim.cmd.NullLsInfo)
	map("n", "<leader>lf", vim.lsp.buf.format)
end

M.config = function()
	local nls = require("null-ls")

	local code_actions = nls.builtins.code_actions
	local completion = nls.builtins.completion
	local formatting = nls.builtins.formatting
	local diagnostics = nls.builtins.diagnostics

	local eslint_opts = {
		extra_filetypes = { "svelte", "astro" },
		condition = function(utils)
			return utils.root_has_file({ ".eslintrc", ".eslintrc.json", ".eslintrc.js", ".eslintrc.cjs" })
		end,
	}

	require("config.plugins.colors").safe_hl("NullLsInfoBorder", { link = "FloatBorder" })
	nls.setup({
		border = "rounded",
		sources = {
			-- General
			completion.spell.with({ filetypes = { "markdown", "latex" } }),
			formatting.cbfmt,
			formatting.yamlfmt,

			-- Git
			code_actions.gitsigns,

			-- Lua
			formatting.stylua,

			-- Web Dev
			formatting.prettierd.with({
				filetypes = { "html", "css", "yaml", "astro" },
			}),
			require("none-ls.formatting.jq"),

			require("none-ls.code_actions.eslint_d").with(eslint_opts), -- code_actions.eslint_d.with(eslint_opts),
			require("none-ls.diagnostics.eslint_d").with(eslint_opts), -- diagnostics.eslint_d.with(eslint_opts),
			require("none-ls.formatting.eslint_d").with(eslint_opts),
			-- formatting.eslint_d.with(eslint_opts),

			-- Python
			formatting.isort,
			formatting.black, -- for tabs instead of spaces, install black-with-tabs(pip install black-with-tabs)
			-- formatting.yapf,
			-- require("none-ls.formatting.reorder_python_imports"),
			-- formatting.reorder_python_imports,
			-- formatting.isort,

			-- Shell
			require("none-ls-shellcheck.code_actions").with({
				extra_filetypes = { "zsh" },
				condition = function()
					return vim.fn.expand("%:t") ~= ".env"
				end,
			}),
			-- diagnostics.shellcheck.with({
			-- 	extra_filetypes = { "zsh" },
			-- 	condition = function()
			-- 		return vim.fn.expand("%:t") ~= ".env"
			-- 	end,
			-- 	diagnostic_config = {
			-- 		update_in_insert = true,
			-- 	},
			-- }),
			formatting.shfmt.with({
				extra_filetypes = { "zsh" },
			}),

			-- YAML
			diagnostics.yamllint.with({
				extra_args = { "-c", "/Users/vishal/.config/yamllint/config/default" },
			}),
		},
	})

	vim.api.nvim_create_user_command("NullLsStop", null_ls_stop, {})
	vim.api.nvim_create_user_command("NullLsToggle", function()
		require("null-ls").toggle({})
	end, {})
	vim.api.nvim_create_user_command("NullLsRestart", null_ls_restart, {})
end

return M
