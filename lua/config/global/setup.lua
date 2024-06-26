require("config.global.settings")

local M = {}

---@param hlgroup_name string
---@param attr string
function M.get_hex(hlgroup_name, attr)
	local vim_fn = vim.fn

	local hlgroup_ID = vim_fn.synIDtrans(vim_fn.hlID(hlgroup_name))
	local hex = vim_fn.synIDattr(hlgroup_ID, attr)
	return hex ~= "" and hex or "NONE"
end

---@param code string
---@param options table<string, any>
function M.hl(code, options)
	local ok, _ = pcall(vim.api.nvim_set_hl, 0, code, options)
	if not ok then
		print("[DEBUG] Could not highlight: '" .. code .. "'", vim.inspect(options))
	end
end

M.icons = require("config.global.icons")

M.lsp = {
	signs = {
		Error = M.icons.diagnostics.BoldError,
		Warn = M.icons.diagnostics.BoldWarning,
		Hint = M.icons.diagnostics.BoldHint,
		Info = M.icons.diagnostics.BoldInformation,
		Other = M.icons.diagnostics.BoldQuestion,
	},
	utils = {
		eslint_config_names = {
			"eslint.config.ts",
			"eslint.config.js",
			"eslint.config.mjs",
			"eslint.config.cjs",

			".eslintrc.ts",
			".eslintrc.js",
			".eslintrc.mjs",
			".eslintrc.cjs",

			".eslintrc.yaml",
			".eslintrc.yml",

			".eslintrc.json",
			".eslintrc.json5",
		},

		prettier_config_names = {
			".prettierrc",

			".prettierrc.json",
			".prettierrc.json5",

			".prettierrc.yml",
			".prettierrc.yaml",

			".prettierrc.ts",
			".prettierrc.js",
			".prettierrc.cjs",
			".prettierrc.mjs",

			"prettier.config.ts",
			"prettier.config.js",
			"prettier.config.cjs",
			"prettier.config.mjs",

			".prettierrc.toml",
		},

		tailwind_config_names = {
			"tailwind.config.ts",
			"tailwind.config.js",
			"tailwind.config.cjs",
			"tailwind.config.mjs",
		},
	},
}

_G.Config = M
