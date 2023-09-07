local M = {
	"nvim-neo-tree/neo-tree.nvim",
	enabled = true,
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"kyazdani42/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
}

M.keys = {
	{
		"<leader>e",
		function()
			if vim.bo.filetype == "neo-tree" then
				pcall(vim.cmd.Neotree, "close")
				return
			end
			pcall(vim.cmd.Neotree, "toggle")
		end,
	},
}

M.cond = function()
	local exclude_filetypes = { "man" }
	return not vim.tbl_contains(exclude_filetypes, vim.bo.filetype)
end

local c = require("config.plugins.colors")
local hl = c.safe_hl
local get_hex = c.get_hex

M.init = function()
	hl("NeoTreeNormal", { link = "NormalAlt" })
	hl("NeoTreeNormalNC", { link = "NormalAlt" })
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
		-- BEGIN NerdFonts V3 fix --
		default_component_configs = {
			icon = {
				folder_empty = "󰜌",
				folder_empty_open = "󰜌",
			},
			git_status = {
				symbols = {
					renamed = "󰁕",
					unstaged = "󰄱",
				},
			},
		},
		document_symbols = {
			kinds = {
				File = { icon = "󰈙", hl = "Tag" },
				Namespace = { icon = "󰌗", hl = "Include" },
				Package = { icon = "󰏖", hl = "Label" },
				Class = { icon = "󰌗", hl = "Include" },
				Property = { icon = "󰆧", hl = "@property" },
				Enum = { icon = "󰒻", hl = "@number" },
				Function = { icon = "󰊕", hl = "Function" },
				String = { icon = "󰀬", hl = "String" },
				Number = { icon = "󰎠", hl = "Number" },
				Array = { icon = "󰅪", hl = "Type" },
				Object = { icon = "󰅩", hl = "Type" },
				Key = { icon = "󰌋", hl = "" },
				Struct = { icon = "󰌗", hl = "Type" },
				Operator = { icon = "󰆕", hl = "Operator" },
				TypeParameter = { icon = "󰊄", hl = "Type" },
				StaticMethod = { icon = "󰠄 ", hl = "Function" },
			},
		},
		-- END NerdFonts V3 fix --
		filesystem = {
			-- hijack_netrw_behavior = "open_default",
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
			follow_current_file = {
				enabled = true
			}, -- This will find and focus the file in the active buffer every
		},
	})

	local neotree_bg = get_hex("NeoTreeNormal", "bg")
	hl("NeoTreeWinSeparator", { fg = neotree_bg, bg = neotree_bg })
end

return M
