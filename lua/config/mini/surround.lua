local function visual_surround(char)
	return [[:<C-u>lua MiniSurround.add('visual')<CR>]] .. char .. [[gvll]]
end

return {
	"echasnovski/mini.surround",
	version = "*",
	opts = {
		mappings = {
			add = "<leader>sa",         -- Add surrounding in Normal and Visual modes
			delete = "<leader>sd",      -- Delete surrounding
			find = "]",                 -- Find surrounding (to the right)
			find_left = "[",            -- Find surrounding (to the left)
			highlight = "<leader>sh",   -- Highlight surrounding
			replace = "<leader>sr",     -- Replace surrounding
			update_n_lines = "<leader>sn", -- Update `n_lines`
		},
	},

	keys = {
		"<leader>sa",
		"<leader>sr",
		"<leader>sh",
		"<leader>sn",
		"<leader>sd",
		{ '"', visual_surround('"'), mode = "v" },
		{ "'", visual_surround("'"), mode = "v" },
		{ "`", visual_surround("`"), mode = "v" },
		{ "(", visual_surround(")"), mode = "v" },
		{ "[", visual_surround("]"), mode = "v" },
		{ "{", visual_surround("}"), mode = "v" },
		{ "<", visual_surround(">"), mode = "v" },
		{ "*", visual_surround("*"), mode = "v" },
		{ "_", visual_surround("_"), mode = "v" },
	},
}
