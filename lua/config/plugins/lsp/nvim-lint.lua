local M = {
	"mfussenegger/nvim-lint",
	enabled = true,
}

M.config = function()
	local lint = require("lint")
	lint.linters_by_ft = {
		javascript = { "eslint_d" },
		typescript = { "eslint_d" },
		zsh = { "shellcheck" },
	}

	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged", "TextChangedI" }, {
		callback = function()
			lint.try_lint()
		end,
	})
end

return M
