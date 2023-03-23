local M = {
	"echasnovski/mini.cursorword",
	enabled = false,
	branch = "stable",
	event = "VeryLazy",
}

M.config = function()
	_G.cursorword_blocklist = function()
		---@diagnostic disable-next-line: missing-parameter
		local curword = vim.fn.expand("<cword>")
		local filetype = vim.api.nvim_buf_get_option(0, "filetype")
		local blocklist = {}
		-- Add any disabling global or filetype-specific logic here
		if filetype == "lua" then
			blocklist = { "local", "require", "--" }
		elseif filetype == "javascript" or filetype == "typescript" then
			blocklist = { "import", "from" }
		elseif filetype == "python" then
			blocklist = { "import", "from" }
		elseif filetype == "NvimTree" then
			blocklist = { "", "" }
		end

		vim.b.minicursorword_disable = vim.tbl_contains(blocklist, curword)
	end

	-- -- Make sure to add this autocommand *before* calling module's `setup()`.
	vim.cmd([[au CursorMoved * lua _G.cursorword_blocklist()]])
	vim.api.nvim_set_hl(0, "MiniCursorWord", { underdotted = true })
	require("mini.cursorword").setup({ delay = 300 })
end

return M
