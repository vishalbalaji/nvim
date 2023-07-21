local M = {
	"codota/tabnine-nvim",
	build = "./dl_binaries.sh",
	enabled = true,
	event = "VeryLazy",
}

M.config = function()
	local comment_fg = require("config.plugins.colors").get_hex("Comment", "fg")

	require("tabnine").setup({
		disable_auto_comment = true,
		accept_keymap = "<C-Cr>",
		dismiss_keymap = "<C-]>",
		debounce_ms = 500,
		suggestion_color = { gui = comment_fg, cterm = 244 },
		exclude_filetypes = { "TelescopePrompt" },
		log_file_path = nil, -- absolute path to Tabnine log file
	})
end

return M
