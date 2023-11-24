local right = vim.api.nvim_replace_termcodes("<M-l>", true, false, true)
local left = vim.api.nvim_replace_termcodes("<M-h>", true, false, true)

local function move_single(key_code)
	local count = vim.v.count
	if count == 0 then
		count = ""
	end
	vim.api.nvim_feedkeys("v", "n", false)
	vim.api.nvim_feedkeys(count .. key_code, "v", false)
end

local M = {
	"echasnovski/mini.move",
	enabled = true,
	version = "*",
	event = "VeryLazy",
	config = {
		mappings = {
			line_right = "",
			line_left = "",
		},
	},
	init = function()
		local map = require("config.keymaps")
		map("n", "<M-l>", function()
			move_single(right)
		end)
		map("n", "<M-h>", function()
			move_single(left)
		end)
	end,
}

return M
