local root_pattern = require("lspconfig.util").root_pattern
local M = {}

M.sumneko_lua = {
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			type = {
				weakUnionCheck = true,
				weakNilCheck = true,
				castNumberToInteger = true,
			},
			format = {
				enable = false,
			},
			hint = {
				enable = true,
				arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
				await = true,
				paramName = "Disable", -- "All", "Literal", "Disable"
				paramType = false,
				semicolon = "Disable", -- "All", "SameLine", "Disable"
				setType = true,
			},
			runtime = {
				version = "LuaJIT",
				special = {
					reload = "require",
				},
			},
			diagnostics = {
				workspaceDelay = -1,
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
			telemetry = {
				enable = false,
			},
		},
	},
}

M.pyright = {
	cmd = { "pyright-langserver", "--stdio" },
	root_pattern = vim.loop.cwd,
}

M.tsserver = {
	root_dir = root_pattern("package.json"),
	init_options = {
		preferences = {
			includeInlayParameterNameHints = "all",
			includeInlayParameterNameHintsWhenArgumentMatchesName = true,
			includeInlayFunctionParameterTypeHints = true,
			includeInlayVariableTypeHints = true,
			includeInlayPropertyDeclarationTypeHints = true,
			includeInlayFunctionLikeReturnTypeHints = false,
			includeInlayEnumMemberValueHints = true,
			importModuleSpecifierPreference = "non-relative",
		},
	},
}

M.denols = {
	root_dir = root_pattern("deno.json", "deno.jsonc"),
}

M.tailwindcss = {
	root_dir = root_pattern("tailwind.config.*js", "tailwind.config.*ts", "postcss.config.*js", "postcss.config.*ts"),
}

M.emmet_ls = {
	extra_filetypes = { "svelte" },
}

M.bashls = {
	disabled = vim.fn.expand("%:t") == ".env",
}

M.gopls = {
	settings = {
		gopls = {
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
}

return M
