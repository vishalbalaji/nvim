local config_dir = "config"

pcall(require, config_dir .. ".global.setup")

require("lib.lazy").setup(config_dir, {
	change_detection = {
		enabled = false,
	},
	install = {
		colorscheme = { "github_dark_default" },
	},
	ui = {
		-- border = "rounded",
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

vim.keymap.set("n", "<leader>p", function()
	pcall(vim.cmd.Lazy)
end, { desc = "Open Lazy [P]ackages" })
