local M = {
	"nvim-neo-tree/neo-tree.nvim",
	enabled = true,
	cmd = "Neotree",
	branch = "v2.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"kyazdani42/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	cond = function()
		local exclude_filetypes = { "man" }
		return not vim.tbl_contains(exclude_filetypes, vim.bo.filetype)
	end,
}

local c = require("config.plugins.colors")
local hl = c.safe_hl
local get_hex = c.get_hex

M.init = function()
	vim.keymap.set("n", "<leader>e", function()
		pcall(vim.cmd.Neotree, "toggle")
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
