return {
	"mg979/vim-visual-multi",
	branch = "master",
	dependencies = {
		require("config.colorscheme"),
	},
	keys = {
		{ "<M-n>", desc = "Find Under", mode = "n" },
		{ "<M-n>", desc = "Find Subword Under", mode = "v" },
		{ "<M-S-n>", desc = "Select All", mode = "n" },
		{ "<M-S-n>", desc = "Visual All", mode = "v" },
		{ "<M-a>", desc = "Add Cursor At Pos", mode = "n" },
		{ "<M-S-k>", desc = "Add Cursor Up" },
		{ "<M-S-j>", desc = "Add Cursor Down" },
		{ "<M-LeftMouse>", desc = "Mouse Cursor" },
		{ "<M-RightMouse>", desc = "Mouse Column" },
	},
	init = function(plugin)
		vim.g.VM_highlight_matches = ""
		vim.g.VM_set_statusline = 0
		vim.g.VM_silent_exit = 1
		vim.g.VM_show_warnings = 0
		vim.g.VM_add_cursor_at_pos_no_mappings = true

		vim.g.VM_default_mappings = 0
		local maps = {
			["Undo"] = "u",
			["Redo"] = "<C-r>",
			["Switch Mode"] = "v",
		}

		for _, mapping in ipairs(plugin.keys) do
			maps[mapping.desc] = mapping[1]
		end

		vim.g.VM_maps = maps

		vim.g.VM_custom_remaps = {
			["p"] = '"+<Plug>(VM-p-Paste)',
			["y"] = '"+<Plug>(VM-Yank)',
		}

		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function ()
				Config.util.hl("VM_Mono", { standout = true })
				Config.util.hl("VM_Cursor", { standout = true })
				Config.util.hl("VM_Insert", { standout = true })
			end
		})
	end,
}
