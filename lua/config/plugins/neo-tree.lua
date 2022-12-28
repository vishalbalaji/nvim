local get_hex = function(hlgroup_name, attr)
	local vim_fn = vim.fn

	local hlgroup_ID = vim_fn.synIDtrans(vim_fn.hlID(hlgroup_name))
	local hex = vim_fn.synIDattr(hlgroup_ID, attr)
	return hex ~= "" and hex or "NONE"
end

local hl = require("config.plugins.colors").hl

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

	hl("NeoTreeNormal", { link = "NormalAlt" })
	hl("NeoTreeNormalNC", { link = "NvimTreeNormal" })
end

M.is_neotree_open = function()
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), "ft") == "neo-tree" then
			return true
		end
	end
	return false
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

	local neotree_bg = get_hex("NeoTreeNormal", "bg")
	hl("NeoTreeWinSeparator", { fg = neotree_bg, bg = neotree_bg })
end

return M
