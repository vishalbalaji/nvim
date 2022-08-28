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
