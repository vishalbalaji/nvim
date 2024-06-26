local right = vim.api.nvim_replace_termcodes("<M-l>", true, false, true)
local left = vim.api.nvim_replace_termcodes("<M-h>", true, false, true)

local function move_single(key_code)
	local count = vim.v.count
	if count == 0 then
		count = ""
	end
	vim.api.nvim_feedkeys("v", "n", false)
	vim.api.nvim_feedkeys(count .. key_code, "v", false)
	vim.api.nvim_feedkeys("v", "n", false)
end

return {
	"echasnovski/mini.move",
	version = "*",
	opts = {
		mappings = {
			line_right = "",
			line_left = "",
		},
	},
	keys = {
		"<M-k>",
		"<M-j>",
		{ ">", "<Nop>", mode = "v" },
		{ "<M-h>", mode = "v" },
		{ "<M-j>", mode = "v" },
		{ "<M-k>", mode = "v" },
		{ "<M-l>", mode = "v" },
		{
			"<M-l>",
			function()
				move_single(right)
			end,
			mode = "n",
		},
		{
			"<M-h>",
			function()
				move_single(left)
			end,
			mode = "n",
		},
	},
}
