local M = {
	"stevearc/conform.nvim",
	enabled = true,
}

M.init = function()
	local map = require("config.keymaps")
	map("n", "<leader>ci", vim.cmd.ConformInfo)
	map("n", "<leader>lf", require("conform").format)
end

M.config = function()
	require("conform").setup({
		formatters_by_ft = {
			["*"] = { "trim_whitespace", "trim_newlines" },
			lua = { "stylua" },
			python = { "isort", "black" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			json = { "prettierd" },
			html = { "prettierd" },
			css = { "prettierd" },
			yaml = { "prettierd" },
			zsh = { "shfmt" },
			bash = { "shfmt" },
			sh = { "shfmt" },
		},
	})
end

return M
