local M = {}

local null_ls_stop = function()
	local null_ls_client
	for _, client in ipairs(vim.lsp.get_active_clients()) do
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
	for _, client in ipairs(vim.lsp.get_active_clients()) do
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

M.setup = function(lsp)
	local null_ls = require("null-ls")
	local null_opts = lsp.build_options("null-ls", {})

	local code_actions = null_ls.builtins.code_actions
	local completion = null_ls.builtins.completion
	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics

	local eslint_opts = {
		extra_filetypes = { "svelte" },
		condition = function(utils)
			return utils.root_has_file({ ".eslintrc", ".eslintrc.json", ".eslintrc.js", ".eslintrc.cjs" })
		end,
	}

	null_ls.setup({
		on_attach = function(client, bufnr)
			null_opts.on_attach(client, bufnr)
		end,
		sources = {
			-- General
			completion.spell.with({ filetypes = { "markdown", "latex" } }),
			formatting.cbfmt,
			formatting.yamlfmt,

			-- Lua
			formatting.stylua,

			-- Web Dev
			formatting.prettierd.with({
				filetypes = { "json", "html", "css" },
			}),
			code_actions.eslint_d.with(eslint_opts),
			diagnostics.eslint_d.with(eslint_opts),
			formatting.eslint_d.with(eslint_opts),

			-- Python
			formatting.reorder_python_imports,
			formatting.yapf.with({
				extra_args = { "--style", "{ use_tabs: true }" },
			}),

			-- Shell
			code_actions.shellcheck.with({
				extra_filetypes = { "zsh" },
				condition = function()
					return vim.fn.expand("%:t") ~= ".env"
				end,
			}),
			diagnostics.shellcheck.with({
				extra_filetypes = { "zsh" },
				condition = function()
					return vim.fn.expand("%:t") ~= ".env"
				end,
				diagnostic_config = {
					update_in_insert = true,
				},
			}),
			formatting.shfmt.with({
				extra_filetypes = { "zsh" },
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
