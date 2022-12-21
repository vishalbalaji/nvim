local M = {}

M.get_settings = function()
	local lspconfig = require("lspconfig")
	local N = {}

	N.sumneko_lua = {

		-- settings = {
		-- 	Lua = {
		-- 		type = {
		-- 			weakUnionCheck = true,
		-- 			weakNilCheck = true,
		-- 			castNumberToInteger = true,
		-- 		},
		-- 		format = {
		-- 			enable = false,
		-- 		},
		-- 		hint = {
		-- 			enable = true,
		-- 			arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
		-- 			await = true,
		-- 			paramName = "Disable", -- "All", "Literal", "Disable"
		-- 			paramType = false,
		-- 			semicolon = "Disable", -- "All", "SameLine", "Disable"
		-- 			setType = true,
		-- 		},
		-- 		runtime = {
		-- 			version = "LuaJIT",
		-- 			special = {
		-- 				reload = "require",
		-- 			},
		-- 		},
		-- 		diagnostics = {
		-- 			workspaceDelay = -1,
		-- 		},
		-- 		workspace = {
		-- 			library = {
		-- 				[vim.fn.expand("$VIMRUNTIME/lua")] = true,
		-- 				[vim.fn.stdpath("config") .. "/lua"] = true,
		-- 				-- [vim.fn.datapath "config" .. "/lua"] = true,
		-- 			},
		-- 		},
		-- 		telemetry = {
		-- 			enable = false,
		-- 		},
		-- 	},
		-- },
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			diagnostics = {
				workspaceDelay = -1,
				globals = { "vim" },
			},
		},
	}

	N.tsserver = {
		root_dir = lspconfig.util.root_pattern("package.json"),
		init_options = {
			preferences = {
				importModuleSpecifierPreference = "non-relative",
			},
		},
	}

	N.pyright = {
		cmd = { "pyright-langserver", "--stdio" },
		root_pattern = vim.loop.cwd,
	}

	N.denols = {
		root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
	}

	return N
end

return M
