-- Pairs
require("mini.pairs").setup({})
vim.api.nvim_set_keymap(
	"i",
	" ",
	[[v:lua.MiniPairs.open('  ', '[%(%[{][%)%]}]')]],
	{ silent = true, expr = true, noremap = true }
)

-- Surround
require("mini.surround").setup({
	mappings = {
		add = "<leader>sa", -- Add surrounding in Normal and Visual modes
		delete = "<leader>sd", -- Delete surrounding
		find = "]", -- Find surrounding (to the right)
		find_left = "[", -- Find surrounding (to the left)
		highlight = "<leader>sh", -- Highlight surrounding
		replace = "<leader>sr", -- Replace surrounding
		update_n_lines = "<leader>sn", -- Update `n_lines`
	},
})

-- Cursorword
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
