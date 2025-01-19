return {
	"kdheepak/lazygit.nvim",
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	-- optional for floating window border decoration
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	-- setting the keybinding for LazyGit with 'keys' is recommended in
	-- order to load the plugin when the command is run for the first time
	keys = {
		{ "<leader>g", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit" },
	},
	init = function()
		Config.util.hl("LazyGitFloat", { link = "NormalAlt" })
		Config.util.hl("LazyGitBorder", { link = "FloatBorder" })

		vim.g.lazygit_floating_window_border_chars = { "", "", "", "", "", "", "", "" } -- customize lazygit popup window border characters
	end,
}
