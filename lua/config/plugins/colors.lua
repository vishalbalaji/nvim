local M = {
	"marko-cerovac/material.nvim",
	enabled = true,
}

-- General Highlights
M.hl = function(code, options)
	pcall(vim.api.nvim_set_hl, 0, code, options)
end

local function general_hls()
	local colors = M.get_colors()
	local hl = M.hl

	-- hl("NormalAlt", { link = "Normal" })
	hl("NormalAlt", { bg = colors.bg_alt })
	hl("Comment", { fg = colors.comment_fg, bold = true, italic = true })
	hl("NonText", { bg = "NONE", fg = colors.comment_fg })
	hl("SpellBad", { link = "DiagnosticUnderlineError" })
	hl("SpellBad", { undercurl = true, special = colors.red })
	hl("NormalFloat", { fg = "fg", bg = "NONE" })
	hl("FloatBorder", { fg = colors.comment_fg, bg = "NONE" })
	hl("WinSeparator", { link = "FloatBorder" })
	hl("Pmenu", { fg = "fg", bg = "NONE" })
	hl("PmenuThumb", { bg = "fg" })
	hl("SignColumn", { fg = "fg", bg = "NONE" })
	hl("TreesitterContext", { bg = colors.bg_alt })
	hl("TreesitterContextBottom", { underline = true, fg = colors.comment_fg })
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


M.get_colors = function ()
	local colors = require("material.colors")
	local bg_alt = colors.editor.bg_alt
	local comment_fg = colors.syntax.comments
	colors = colors.main
	colors.bg_alt = bg_alt
	colors.comment_fg = comment_fg
	return colors
end

return M
