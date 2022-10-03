vim.g.terminal_colors = false
local colors = {
	bg = "#282c34",
	fg = "#bbc2cf",

	bg_alt = "#21242b",
	fg_alt = "#5b6268",

	base0 = "#1b2229",
	base1 = "#1c1e1e",
	base2 = "#202328",
	base3 = "#23272e",
	base4 = "#3f444a",
	base5 = "#5b6268",
	base6 = "#73797e",
	base7 = "#9ca0a4",
	base8 = "#dfdfdf",

	grey = "#3f444a",
	red = "#ff6c6b",
	orange = "#da8548",
	green = "#98be65",
	teal = "#4db5bd",
	yellow = "#ecbe7b",
	blue = "#51afef",
	dark_blue = "#2257a0",
	magenta = "#c678dd",
	violet = "#a9a1e1",
	cyan = "#46d9ff",
	dark_cyan = "#5699af",
}

vim.cmd([[
try
  colorscheme doom-one
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry

function! SynGroup()
  let l:s = synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
]])

local hl = vim.api.nvim_set_hl
local comment_fg = vim.api.nvim_get_hl_by_name("Comment", true).foreground
local error_fg = colors.red
local context = colors.gray or colors.grey

-- General Highlights
-- hl(0, "Normal", { fg = "fg", bg = "NONE" })
hl(0, "Comment", { fg = comment_fg, bold = true, italic = true })
hl(0, "NonText", { bg = "NONE", fg = comment_fg })
hl(0, "SpellBad", { sp = error_fg, undercurl = true })
hl(0, "NormalFloat", { fg = "fg", bg = "NONE" })
hl(0, "FloatBorder", { fg = comment_fg, bg = "NONE" })
hl(0, "WinSeparator", { link = "FloatBorder" })

-- Headlines
require("headlines").setup({})
hl(0, "Quote", { fg = colors.blue, bold = true })

-- NvimTree
hl(0, "NvimTreeNormal", { link = "Normal" })
hl(0, "NvimTreeNormalNC", { link = "Normal" })
hl(0, "NvimTreeWinSeparator", { link = "WinSeparator" })

-- Trouble
hl(0, "TroubleNormal", { link = "Normal" })

-- WhichKey
hl(0, "WhichKeyFloat", { link = "Normal" })

-- Telescope
hl(0, "TelescopeNormal", { link = "NormalFloat" })
hl(0, "TelescopeBorder", { link = "TelescopeNormal" })

-- Popup
hl(0, "Pmenu", { fg = "fg", bg = "NONE" })
hl(0, "PmenuThumb", { bg = "fg" })
hl(0, "SignColumn", { fg = "fg", bg = "NONE" })

-- CursorWord
hl(0, "MiniCursorWord", { underdotted = true })

-- Diagnostics
hl(0, "DiagnosticError", { fg = colors.red })
hl(0, "DiagnosticWarn", { fg = colors.yellow })
hl(0, "DiagnosticInfo", { fg = colors.blue })
hl(0, "DiagnostiHint", { fg = colors.green })

-- Diffs
hl(0, "DiffAdd", { fg = colors.green })
hl(0, "DiffChange", { fg = colors.yellow })
hl(0, "DiffDelete", { fg = colors.red })
hl(0, "GitSignsAdd", { link = "DiffAdd" })
hl(0, "GitSignsChange", { link = "DiffChange" })
hl(0, "GitSignsDelete", { link = "DiffDelete" })

-- Cokeline
hl(0, "TablineFill", { link = "Normal" })

-- Navic
hl(0, "NavicIconsFile", { link = "CmpItemKindFile" })
hl(0, "NavicIconsModule", { link = "CmpItemKindModule" })
hl(0, "NavicIconsNamespace", { link = "CmpItemKindModule" })
hl(0, "NavicIconsPackage", { link = "CmpItemKindModule" })
hl(0, "NavicIconsClass", { link = "CmpItemKindClass" })
hl(0, "NavicIconsMethod", { link = "CmpItemKindMethod" })
hl(0, "NavicIconsProperty", { link = "CmpItemKindProperty" })
hl(0, "NavicIconsField", { link = "CmpItemKindField" })
hl(0, "NavicIconsConstructor", { link = "CmpItemKindConstructor" })
hl(0, "NavicIconsEnum", { link = "CmpItemKindEnum" })
hl(0, "NavicIconsInterface", { link = "CmpItemKindInterface" })
hl(0, "NavicIconsFunction", { link = "CmpItemKindFunction" })
hl(0, "NavicIconsVariable", { link = "CmpItemKindVariable" })
hl(0, "NavicIconsConstant", { link = "CmpItemKindConstant" })
hl(0, "NavicIconsString", { link = "String" })
hl(0, "NavicIconsNumber", { link = "Number" })
hl(0, "NavicIconsBoolean", { link = "Boolean" })
hl(0, "NavicIconsArray", { link = "CmpItemKindClass" })
hl(0, "NavicIconsObject", { link = "CmpItemKindClass" })
hl(0, "NavicIconsKey", { link = "CmpItemKindKeyword" })
hl(0, "NavicIconsKeyword", { link = "CmpItemKindKeyword" })
hl(0, "NavicIconsNull", { fg = colors.blue, bg = "NONE" })
hl(0, "NavicIconsEnumMember", { link = "CmpItemKindEnumMember" })
hl(0, "NavicIconsStruct", { link = "CmpItemKindStruct" })
hl(0, "NavicIconsEvent", { link = "CmpItemKindEvent" })
hl(0, "NavicIconsOperator", { link = "CmpItemKindOperator" })
hl(0, "NavicIconsTypeParameter", { link = "CmpItemKindTypeParameter" })
hl(0, "NavicText", { fg = comment_fg, bg = "NONE" })
hl(0, "NavicSeparator", { fg = context, bg = "NONE" })
hl(0, "NavicText", { fg = comment_fg, bg = "NONE" })
hl(0, "NavicSeparator", { fg = context, bg = "NONE" })

return colors
