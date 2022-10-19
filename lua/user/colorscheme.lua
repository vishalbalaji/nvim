vim.g.doom_one_terminal_colors = false
local colors = require("doom-one.colors")[vim.o.background]
local colorscheme = "doom-one"

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
	hl(0, "Comment", { fg = comment_fg, bold = true, italic = true })
	hl(0, "NonText", { bg = "NONE", fg = comment_fg })
	hl(0, "SpellBad", { link = "DiagnosticUnderlineError" })
	hl(0, "NormalFloat", { fg = "fg", bg = "NONE" })
	hl(0, "FloatBorder", { fg = comment_fg, bg = "NONE" })
	hl(0, "WinSeparator", { link = "FloatBorder" })
	hl(0, "Pmenu", { fg = "fg", bg = "NONE" })
	hl(0, "PmenuThumb", { bg = "fg" })
	hl(0, "SignColumn", { fg = "fg", bg = "NONE" })
end

-- Headlines
local function headlines_hls()
  require("headlines").setup({ markdown = { fat_headlines = false } })
	hl(0, "Quote", { fg = colors.blue, bold = true })
end

-- NvimTree
local function nvimtree_hls()
	hl(0, "NvimTreeNormal", { link = "Normal" })
	hl(0, "NvimTreeNormalNC", { link = "Normal" })
	hl(0, "NvimTreeWinSeparator", { link = "WinSeparator" })
end

-- Trouble
local function trouble_hls()
	hl(0, "TroubleNormal", { link = "Normal" })
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
	hl(0, "DiagnosticError", { fg = colors.red })
	hl(0, "DiagnosticWarn", { fg = colors.yellow })
	hl(0, "DiagnosticInfo", { fg = colors.blue })
	hl(0, "DiagnosticHint", { fg = colors.green })
	hl(0, "DiagnosticUnderlineError", { undercurl = true, fg = colors.red })
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

general_hls()
headlines_hls()
nvimtree_hls()
trouble_hls()
quickscope_hls()
whichkey_hls()
telescope_hls()
cursorword_hls()
lsp_hls()
git_hls()
cokeline_hls()

return colors
