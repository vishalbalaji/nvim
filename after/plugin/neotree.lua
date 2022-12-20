local M = {}

vim.g.neo_tree_remove_legacy_commands = 1
vim.g.neotree_visible = false

M.toggle = function()
	vim.cmd.Neotree("toggle")
	vim.g.neotree_visible = not vim.g.neotree_visible
end

vim.keymap.set("n", "<leader>e", M.toggle, { silent = true, noremap = true })

require("neo-tree").setup({
	filesystem = {
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

return M
