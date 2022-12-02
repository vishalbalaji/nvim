---@diagnostic disable: undefined-global
local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

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

vim.api.nvim_create_user_command("NullLsStop", null_ls_stop, {})
vim.api.nvim_create_user_command("NullLsToggle", function()
	-- you can also create commands to disable or enable sources
	require("null-ls").toggle({})
end, {})
vim.api.nvim_create_user_command("NullLsRestart", null_ls_restart, {})

local home_dir = os.getenv("HOME")

local code_actions = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {
	-- General
	-- code_actions.refactoring,
	code_actions.gitsigns,
	completion.spell.with({ filetypes = { "markdown", "latex" } }),
	formatting.cbfmt,
	formatting.yamlfmt,
	diagnostics.commitlint.with({
		extra_args = { "-g", home_dir .. "/.local/share/nvim/commitlint.config.js" },
	}),

	-- CSS
	formatting.prettierd.with({
		filetypes = { "css", "json", "html" },
	}),

	-- Lua
	formatting.stylua,

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

	-- Python
	-- formatting.black,
	-- formatting.isort,
	formatting.reorder_python_imports,
	formatting.yapf.with({
		extra_args = { "--style", "{ use_tabs: true }" },
	}),

	-- TS/JS
	code_actions.eslint_d.with({
		extra_filetypes = { "svelte" },
		condition = function(utils)
			return utils.root_has_file({ ".eslintrc", ".eslintrc.json", ".eslintrc.js", ".eslintrc.cjs" })
		end,
	}),
	diagnostics.eslint_d.with({
		extra_filetypes = { "svelte" },
		condition = function(utils)
			return utils.root_has_file({ ".eslintrc", ".eslintrc.json", ".eslintrc.js", ".eslintrc.cjs" })
		end,
	}),
	formatting.eslint_d.with({
		extra_filetypes = { "svelte" },
		condition = function(utils)
			return utils.root_has_file({ ".eslintrc", ".eslintrc.json", ".eslintrc.js", ".eslintrc.cjs" })
		end,
	}),
}

null_ls.setup({ sources = sources })
