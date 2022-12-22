local M = {
	"nvim-neo-tree/neo-tree.nvim",
	enabled = true,
	cmd = "Neotree",
	branch = "v2.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
}

M.init = function()
	vim.keymap.set("n", "<leader>e", function()
		vim.cmd.Neotree("toggle")
	end, { desc = "Neotree" })
end

M.config = function()
	vim.g.neo_tree_remove_legacy_commands = 1

	require("neo-tree").setup({
		filesystem = {
			hijack_netrw_behavior = "open_current",
			window = {
				width = 30,
				mappings = {
					["/"] = "none",
					["<Tab>"] = "open",
					["o"] = "system_open",
				},
			},
			commands = {
				system_open = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					vim.api.nvim_command(string.format("silent !xdg-open '%s' & disown", path))
				end,
			},
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_hidden = false,
			},
			follow_current_file = true, -- This will find and focus the file in the active buffer every
		},
	})

	local c = require("config.plugins.colors")
	local colors = c.get_colors()
	local hl = c.hl

	hl("NeoTreeNormal", { link = "NormalAlt" })
	hl("NeoTreeNormalNC", { link = "NvimTreeNormal" })
	hl("NeoTreeWinSeparator", { bg = colors.bg_alt, fg = colors.bg_alt })
end

return M
