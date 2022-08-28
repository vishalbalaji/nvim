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
