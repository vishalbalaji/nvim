local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

local config = {}
local ignore_filetypes = {
	"NvimTree",
	"TelescopePrompt",
	"Trouble",
	"toggleterm",
	"aerial",
	"noice",
	"packer",
	"harpoon",
}

local transparent = { attribute = "bg", highlight = "TabLineFill" }
local bg_select = { attribute = "bg", highlight = "NormalAlt" }

config.highlights = {
	fill = { bg = transparent },
	background = { bg = transparent },
	numbers = { bg = transparent },
	close_button = { bg = transparent },
	modified = { bg = transparent },
	separator = { bg = transparent, fg = transparent },
	indicator = { bg = transparent, fg = transparent },
	offset_separator = {
		fg = { attribute = "fg", highlight = "NvimTreeWinSeparator" },
		bg = { attribute = "bg", highlight = "NvimTreeWinSeparator" },
	},

	error = { bg = transparent },
	warning = { bg = transparent },
	hint = { bg = transparent },
	error_diagnostic = { bg = transparent, fg = { attribute = "fg", highlight = "DiagnosticError" } },
	warning_diagnostic = { bg = transparent, fg = { attribute = "fg", highlight = "DiagnosticWarn" } },
	hint_diagnostic = { bg = transparent, fg = { attribute = "fg", highlight = "DiagnosticHint" } },

	buffer_selected = { bg = bg_select },
	error_selected = { bg = bg_select },
	warning_selected = { bg = bg_select },
	hint_selected = { bg = bg_select },
	error_diagnostic_selected = { bg = bg_select },
	warning_diagnostic_selected = { bg = bg_select },
	hint_diagnostic_selected = { bg = bg_select },
	close_button_selected = { bg = bg_select },
	modified_selected = { bg = bg_select },
	numbers_selected = { bg = bg_select },
	indicator_selected = { bg = bg_select, fg = bg_select },
}

config.options = {
	mode = "tabs", -- set to "tabs" to only show tabpages instead
	show_close_icon = false,
	numbers = "ordinal",
	custom_filter = function(buf_number)
		if not vim.tbl_contains(ignore_filetypes, vim.bo[buf_number].filetype) then
			return true
		end
	end,
	diagnostics = "nvim_lsp",
	diagnostics_update_in_insert = true,
	---@diagnostic disable-next-line: unused-local
	diagnostics_indicator = function(count, level, diagnostics_dict, context)
		local s = " "
		for e, n in pairs(diagnostics_dict) do
			local sym = e == "error" and "  " or (e == "warning" and "  " or "  ")
			s = s .. sym .. n
		end
		return s:sub(3)
	end,
	offsets = {
		{
			filetype = "NvimTree",
			text = "",
			text_align = "center",
			separator = true,
		},
	},
}

bufferline.setup(config)
