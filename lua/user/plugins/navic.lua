if vim.g.started_by_firenvim then
  return
end

local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
	return
end

local icons = require("user.utils.icons")
local navic_icons = {
	File = " ",
	Module = " ",
	Namespace = " ",
	Package = " ",
	Class = " ",
	Method = " ",
	Property = " ",
	Field = " ",
	Constructor = " ",
	Enum = "練",
	Interface = "練",
	Function = " ",
	Variable = " ",
	Constant = " ",
	String = " ",
	Number = " ",
	Boolean = "◩ ",
	Array = " ",
	Object = " ",
	Key = " ",
	Null = "ﳠ ",
	EnumMember = " ",
	Struct = " ",
	Event = " ",
	Operator = " ",
	TypeParameter = " ",
}

navic.setup({
	icons = navic_icons,
	highlight = true,
	separator = " " .. icons.ui.ChevronRight .. " ",
	depth_limit = 0,
	depth_limit_indicator = "..",
})

local hl = vim.api.nvim_set_hl
local colors = require("user.colorscheme")
local navic_fg = colors.base7 or vim.api.nvim_get_hl_by_name("Comment", true).foreground

local function set_navic_hls()
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
	hl(0, "NavicIconsNull", { fg = colors.blue })
	hl(0, "NavicIconsEnumMember", { link = "CmpItemKindEnumMember" })
	hl(0, "NavicIconsStruct", { link = "CmpItemKindStruct" })
	hl(0, "NavicIconsEvent", { link = "CmpItemKindEvent" })
	hl(0, "NavicIconsOperator", { link = "CmpItemKindOperator" })
	hl(0, "NavicIconsTypeParameter", { link = "CmpItemKindTypeParameter" })
	hl(0, "NavicText", { fg = navic_fg })
	hl(0, "NavicSeparator", { fg = navic_fg })
end

set_navic_hls()
