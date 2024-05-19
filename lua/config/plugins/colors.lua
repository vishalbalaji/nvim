local M = {
	"Everblush/nvim",
	name = "everblush",
	enabled = true,
	lazy = false,
	priority = 1000,
}

_G.print_colors = function()
	print(vim.inspect(require("everblush/palette")))
	-- print(vim.inspect(M.get_colors()))
end

vim.api.nvim_create_user_command("PrintColors", print_colors, {})

-- General Highlights
M.safe_hl = function(code, options)
	local ok, _ = pcall(vim.api.nvim_set_hl, 0, code, options)
	if not ok then
		print("[DEBUG] Could not highlight: '" .. code .. "'", vim.inspect(options))
	end
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
		local palette = require("everblush/palette")
		M.colors = {
			red = palette.color1,
			blue = palette.color4,
			cyan = palette.color6,
			green = palette.color2,
			orange = palette.color9,
			magenta = palette.color5,
			yellow = palette.color3,
		}
	end

	return M.colors
end

local function general_hls()
	local colors = M.get_colors()
	local hl = M.safe_hl

	local c = require("everblush.palette")

	-- hl("NormalAlt", { link = "Normal" })
	hl("NormalAlt", { bg = c.contrast })
	hl("Comment", { fg = c.comment, bold = true, italic = true })
	hl("CursorLine", { bg = c.color0 })
	hl("QuickFixLine", { fg = "fg" })
	hl("TelescopeSelection", { link = "CursorLine" })
	-- hl("LineNr", { link = "Special" })
	hl("CursorLineNr", { link = "SpecialComment" })
	hl("LineNr", { link = "NonText" })
	hl("FoldColumn", { link = "NonText" })
	hl("@float", { link = "@number" })
	hl("@exception", { link = "@debug" })
	hl("WinSeparator", { link = "NonText" })

	local comment_fg = M.get_hex("Comment", "fg")

	hl("NonText", { bg = "NONE", fg = comment_fg })
	hl("SpellBad", { link = "DiagnosticUnderlineError" })
	hl("SpellBad", { undercurl = true, special = colors.red })
	hl("NormalFloat", { fg = "fg", bg = "NONE" })
	hl("ColorColumn", { link = "CursorLine" })
	hl("TelescopeBorder", { link = "FloatBorder" })

	-- hl("FloatBorder", { fg = comment_fg, bg = "NONE" })
	-- hl("WinSeparator", { link = "FloatBorder" })

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
	local colorscheme = "everblush"

	local ok, _ = pcall(function(cmd)
		vim.cmd(cmd)
	end, string.format("colorscheme %s", colorscheme))
	if not ok then
		print("Colorscheme not applied")
		vim.cmd("colorscheme default")
		vim.cmd("set background=dark")
		return
	end

	general_hls()
end

return M
