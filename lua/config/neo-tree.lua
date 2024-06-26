return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		require("config.devicons"),
	},
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<CR>" },
	},
	cmd = "Neotree",
	opts = {
		-- BEGIN NerdFonts V3 fix --
		default_component_configs = {
			icon = {
				folder_empty = "󰜌",
				folder_empty_open = "󰜌",

				default = require("nvim-web-devicons").get_default_icon().icon,
				highlight = "DevIconsDefault",
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
					["<Esc>"] = "esc",
				},
			},
			commands = {
				system_open = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					vim.api.nvim_command(string.format("!xdg-open '%s' &", path))
				end,
				esc = function()
					vim.api.nvim_command("noh")
				end,
			},
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_hidden = false,
			},
			follow_current_file = {
				enabled = true,
			}, -- This will find and focus the file in the active buffer every
		},
	},

	config = function(_, opts)
		require("neo-tree").setup(opts)

		Config.hl("NeoTreeNormal", { link = "NormalAlt" })
		Config.hl("NeoTreeNormalNC", { link = "NormalAlt" })

		local neotree_bg = Config.get_hex("NeoTreeNormal", "bg")
		Config.hl("NeoTreeWinSeparator", { fg = neotree_bg, bg = neotree_bg })
	end,

	init = function()
		vim.api.nvim_create_autocmd("BufEnter", {
			-- make a group to be able to delete it later
			group = vim.api.nvim_create_augroup("NeoTreeInit", { clear = true }),
			callback = function()
				local f = vim.fn.expand("%:p")
				if vim.fn.isdirectory(f) ~= 0 then
					vim.cmd("Neotree current dir=" .. f)
					-- neo-tree is loaded now, delete the init autocmd
					vim.api.nvim_clear_autocmds({ group = "NeoTreeInit" })
				end
			end,
		})
	end,
}
