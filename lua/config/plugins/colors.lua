local M = {
	"marko-cerovac/material.nvim",
	enabled = true,
	lazy = true,
	priority = 1000,
}

_G.print_colors = function()
	print(vim.inspect(M.get_colors()))
end

-- General Highlights
M.safe_hl = function(code, options)
	pcall(vim.api.nvim_set_hl, 0, code, options)
end

-- Same as 'require("cokeline/utils").get_hex'
M.get_hex = function(hlgroup_name, attr)
	local vim_fn = vim.fn

	local hlgroup_ID = vim_fn.synIDtrans(vim_fn.hlID(hlgroup_name))
	local hex = vim_fn.synIDattr(hlgroup_ID, attr)
	return hex ~= "" and hex or "NONE"
end

M.get_colors = function()
	if not M.colors then
		M.colors = require("material.colors").main
	end

	return M.colors
end

local function general_hls()
	local colors = M.get_colors()
	local hl = M.safe_hl

	local c = require("material.colors")

	-- hl("NormalAlt", { link = "Normal" })
	hl("NormalAlt", { bg = c.editor.bg_alt })
	hl("Comment", { fg = c.syntax.comments, bold = true, italic = true })

	local comment_fg = M.get_hex("Comment", "fg")

	hl("NonText", { bg = "NONE", fg = comment_fg })
	hl("SpellBad", { link = "DiagnosticUnderlineError" })
	hl("SpellBad", { undercurl = true, special = colors.red })
	hl("NormalFloat", { fg = "fg", bg = "NONE" })
	hl("FloatBorder", { fg = comment_fg, bg = "NONE" })
	hl("WinSeparator", { link = "FloatBorder" })

	-- -- LSP and completion
	hl("Pmenu", { fg = "fg", bg = "NONE" })
	hl("PmenuThumb", { bg = "fg" })
	hl("SignColumn", { fg = "fg", bg = "NONE" })

	-- -- Markdown
	hl("markdownBold", { fg = colors.blue, bold = true })
	hl("markdownItalic", { fg = colors.green, italic = true })
	hl("markdownBoldItalic", { fg = colors.yellow, bold = true, italic = true })
end

M.init = function()
	local colorscheme = "material"
	vim.g.material_style = "deep ocean"

	require("material").setup({
		disable = {
			colored_cursor = true,
			eob_lines = true,
		},

		high_visibility = {
			darker = true, -- Enable higher contrast text for darker style
		},

		lualine_style = "stealth", -- Lualine style ( can be 'stealth' or 'default' )
		async_loading = false, -- Load parts of the theme asyncronously for faster startup (turned on by default)
	})

	-- Setting colorscheme and _G.colors
	local ok, _ = pcall(vim.cmd, string.format("colorscheme %s", colorscheme))
	if not ok then
		print("Colorscheme not applied")
		vim.cmd("colorscheme default")
		vim.cmd("set background=dark")
		return
	end

	general_hls()
end

return M
