vim.g.material_style = "deep ocean"

local colors = require("material.colors")
local bg_alt = colors.editor.bg_alt
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

local colorscheme = "material"

vim.cmd(
	"try | colorscheme "
		.. colorscheme
		.. " | catch /^Vim%((\a+))=:E185/ | colorscheme default | set background=dark | endtry"
)

vim.cmd([[
function! SynGroup()
  let l:s = synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
]])

local hl = vim.api.nvim_set_hl
local comment_fg = vim.api.nvim_get_hl_by_name("Comment", true).foreground

-- General Highlights
local function general_hls()
	-- hl(0, "NormalAlt", { link = "Normal" })
	hl(0, "NormalAlt", { bg = bg_alt })
	hl(0, "Comment", { fg = comment_fg, bold = true, italic = true })
	hl(0, "NonText", { bg = "NONE", fg = comment_fg })
	-- hl(0, "SpellBad", { link = "DiagnosticUnderlineError" })
	hl(0, "SpellBad", { undercurl = true, special = colors.red })
	hl(0, "NormalFloat", { fg = "fg", bg = "NONE" })
	hl(0, "FloatBorder", { fg = comment_fg, bg = "NONE" })
	hl(0, "WinSeparator", { link = "FloatBorder" })
	hl(0, "Pmenu", { fg = "fg", bg = "NONE" })
	hl(0, "PmenuThumb", { bg = "fg" })
	hl(0, "SignColumn", { fg = "fg", bg = "NONE" })
end

-- NvimTree
local function nvimtree_hls()
	-- hl(0, "NvimTreeNormal", { link = "Normal" })
	-- hl(0, "NvimTreeWinSeparator", { link = "WinSeparator" })
	hl(0, "NvimTreeNormal", { link = "NormalAlt" })
	hl(0, "NvimTreeWinSeparator", { bg = bg_alt, fg = bg_alt })
  hl(0, "NvimTreeNormalNC", { link = "NvimTreeNormal" })
end

-- Trouble
local function trouble_hls()
	hl(0, "TroubleNormal", { link = "NormalAlt" })
end

-- QuickScope
local function quickscope_hls()
	hl(0, "QuickScopePrimary", { fg = colors.green, standout = true })
	hl(0, "QuickScopeSecondary", { fg = colors.yellow, standout = true })
end

-- WhichKey
local function whichkey_hls()
	hl(0, "WhichKeyFloat", { link = "Normal" })
end

-- Telescope
local function telescope_hls()
	hl(0, "TelescopeNormal", { link = "NormalFloat" })
	hl(0, "TelescopeBorder", { link = "TelescopeNormal" })
end

-- CursorWord
local function cursorword_hls()
	hl(0, "MiniCursorWord", { underdotted = true, italic = true })
end

-- Diagnostics
local function lsp_hls()
	hl(0, "LspInlayHint", { fg = comment_fg, bg = "bg", bold = true })
	hl(0, "DiagnosticError", { fg = colors.red })
	hl(0, "DiagnosticWarn", { fg = colors.yellow })
	hl(0, "DiagnosticInfo", { fg = colors.blue })
	hl(0, "DiagnosticHint", { fg = colors.green })
	hl(0, "DiagnosticUnderlineError", { undercurl = true, fg = colors.red })
	hl(0, "LightBulbVirtualText", { bg = vim.api.nvim_get_hl_by_name("CursorLine", true).background, fg = colors.green })
end

-- Diffs
local function git_hls()
	hl(0, "DiffAdd", { fg = colors.green })
	hl(0, "DiffChange", { fg = colors.yellow })
	hl(0, "DiffDelete", { fg = colors.red })
	hl(0, "GitSignsAdd", { link = "DiffAdd" })
	hl(0, "GitSignsChange", { link = "DiffChange" })
	hl(0, "GitSignsDelete", { link = "DiffDelete" })
end

-- Cokeline
local function cokeline_hls()
	hl(0, "TablineFill", { link = "Normal" })
end

-- IndentBlankline
local function indentblankline_hls()
	-- hl(0, "IndentBlanklineContextStart", { special = "fg", underline = true })
	-- hl(0, "IndentBlanklineContextChar", { fg = "fg" })
end

general_hls()
nvimtree_hls()
trouble_hls()
quickscope_hls()
whichkey_hls()
telescope_hls()
cursorword_hls()
lsp_hls()
git_hls()
cokeline_hls()
indentblankline_hls()

return colors
