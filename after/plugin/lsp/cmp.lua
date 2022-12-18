local M = {}

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

M.setup = function ()
	local lsp = require("lsp-zero")
	local cmp        = require("cmp")
	local luasnip    = require("luasnip")
	local cmp_select = { behavior = cmp.SelectBehavior.Insert }
	local cmp_config = lsp.defaults.cmp_config()

	cmp_config.mapping = lsp.defaults.cmp_mappings({
		["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand({})
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
				"i",
				"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
				"i",
				"s",
		}),
	})
	cmp_config.window.completion = cmp.config.window.bordered()
	table.insert(cmp_config.sources, { name = 'emoji', insert = false })

	---@diagnostic disable-next-line: redundant-parameter
	cmp.setup(cmp_config)

	cmp.setup.cmdline(":", {
		mapping = {
			["<Tab>"] = cmp.mapping(cmp.mapping.confirm(), { "i", "c" }),
			["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
			["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
		},
		sources = {
			{ name = "cmdline" },
		},
	})

	cmp.setup.cmdline({ "/", "?" }, {
		mapping = {
			["<Tab>"] = cmp.mapping(cmp.mapping.confirm(), { "i", "c" }),
			["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
			["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
		},
		sources = {
			{ name = "buffer" },
		},
	})
end

return M
