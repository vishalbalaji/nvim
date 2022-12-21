local function set_colorscheme()
	local colorscheme = "material"
	vim.g.material_style = "deep ocean"

	local colors = require("material.colors")
	local bg_alt = colors.editor.bg_alt
	local comment_fg = colors.syntax.comments
	colors = colors.main

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
		vim.cmd("colorscheme default")
		vim.cmd("set background=dark")
		return
	end

	colors.bg_alt = bg_alt
	colors.comment_fg = comment_fg
	_G.colors = colors
end

local function hl(code, options)
	pcall(vim.api.nvim_set_hl, 0, code, options)
end

-- General Highlights
local function general_hls()
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

-- Headlines
local function headlines_hls()
	hl("CodeBlock", { bg = colors.bg_alt })
end

-- Trouble
local function trouble_hls()
	hl("TroubleNormal", { link = "NormalAlt" })
end

-- QuickScope
local function quickscope_hls()
	hl("QuickScopePrimary", { fg = colors.green, standout = true })
	hl("QuickScopeSecondary", { fg = colors.yellow, standout = true })
end

-- Telescope
local function telescope_hls()
	hl("TelescopeNormal", { link = "NormalFloat" })
	hl("TelescopeBorder", { link = "TelescopeNormal" })
end

-- Diagnostics
local function lsp_hls()
	hl("LspInlayHint", { fg = colors.comment_fg, bg = "bg", bold = true })
	hl("DiagnosticError", { fg = colors.red })
	hl("DiagnosticWarn", { fg = colors.yellow })
	hl("DiagnosticInfo", { fg = colors.blue })
	hl("DiagnosticHint", { fg = colors.green })
	hl("DiagnosticUnderlineError", { undercurl = true, fg = colors.red })
end

-- Diffs
local function git_hls()
	hl("DiffAdd", { fg = colors.green })
	hl("DiffChange", { fg = colors.yellow })
	hl("DiffDelete", { fg = colors.red })
	hl("GitSignsAdd", { link = "DiffAdd" })
	hl("GitSignsChange", { link = "DiffChange" })
	hl("GitSignsDelete", { link = "DiffDelete" })
end

-- Cokeline
local function cokeline_hls()
	hl("TablineFill", { link = "Normal" })
end

-- Neotree
local function neotree_hls()
	-- hl("NeoTreeNormal", { link = "Normal" })
	-- hl("NeoTreeWinSeparator", { link = "WinSeparator" })
	hl("NeoTreeNormal", { link = "NormalAlt" })
	hl("NeoTreeWinSeparator", { bg = colors.bg_alt, fg = colors.bg_alt })
	hl("NeoTreeNormalNC", { link = "NvimTreeNormal" })
end

set_colorscheme()
general_hls()
headlines_hls()
trouble_hls()
quickscope_hls()
telescope_hls()
lsp_hls()
git_hls()
cokeline_hls()
neotree_hls()
