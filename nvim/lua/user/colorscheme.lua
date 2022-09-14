vim.cmd([[
try 
  colorscheme doom-one
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
hi Comment gui=bold,italic

function! SynGroup()                                                              
  let l:s = synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')  
endfun
]])

local hl = vim.api.nvim_set_hl

-- Popup
hl(0, "NormalFloat", { fg = "fg", bg = "NONE" })
hl(0, "PmenuThumb", { bg = "#bbc2cf" })

-- Navic
local get_hex = require("cokeline/utils").get_hex
local blue = vim.g.terminal_color_4
local gray = get_hex("Comment", "fg")
local context = vim.g.terminal_color_8

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
hl(0, "NavicIconsNull", { fg = blue, bg = "NONE" })
hl(0, "NavicIconsEnumMember", { link = "CmpItemKindEnumMember" })
hl(0, "NavicIconsStruct", { link = "CmpItemKindStruct" })
hl(0, "NavicIconsEvent", { link = "CmpItemKindEvent" })
hl(0, "NavicIconsOperator", { link = "CmpItemKindOperator" })
hl(0, "NavicIconsTypeParameter", { link = "CmpItemKindTypeParameter" })
hl(0, "NavicText", { fg = gray, bg = "NONE" })
hl(0, "NavicSeparator", { fg = context, bg = "NONE" })

-- -- Color Reference
-- terminal_color_0       #282c34
-- terminal_color_1       #ff6c6b
-- terminal_color_2       #98be65
-- terminal_color_3       #ecbe7b
-- terminal_color_4       #51afef
-- terminal_color_5       #a9a1e1
-- terminal_color_6       #46d9ff
-- terminal_color_7       #bbc2cf
-- terminal_color_8       #3f444a
-- terminal_color_9       #ff6c6b
-- terminal_color_10      #98be65
-- terminal_color_11      #da8548
-- terminal_color_12      #51afef
-- terminal_color_13      #a9a1e1
-- terminal_color_14      #46d9ff
-- terminal_color_background  #21242b

-- dark = {
-- 	bg = "#282c34",
-- 	fg = "#bbc2cf",
--
-- 	bg_alt = "#21242b",
-- 	fg_alt = "#5b6268",
--
-- 	base0 = "#1b2229",
-- 	base1 = "#1c1e1e",
-- 	base2 = "#202328",
-- 	base3 = "#23272e",
-- 	base4 = "#3f444a",
-- 	base5 = "#5b6268",
-- 	base6 = "#73797e",
-- 	base7 = "#9ca0a4",
-- 	base8 = "#dfdfdf",
--
-- 	grey = "#3f444a",
-- 	red = "#ff6c6b",
-- 	orange = "#da8548",
-- 	green = "#98be65",
-- 	teal = "#4db5bd",
-- 	yellow = "#ecbe7b",
-- 	blue = "#51afef",
-- 	dark_blue = "#2257a0",
-- 	magenta = "#c678dd",
-- 	violet = "#a9a1e1",
-- 	cyan = "#46d9ff",
-- 	dark_cyan = "#5699af",
-- },
