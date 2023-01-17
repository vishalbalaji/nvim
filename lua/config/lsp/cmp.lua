local M = {}

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.setup = function(lsp)
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local cmp_select = { behavior = cmp.SelectBehavior.Insert }
	local cmp_config = lsp.defaults.cmp_config()

	local kind_icons = {
		Text = "",
		Method = "m",
		Function = "",
		Constructor = "",
		Field = "",
		Variable = "",
		Class = "",
		Interface = "",
		Module = "",
		Property = "",
		Unit = "",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "",
		Event = "",
		Operator = "",
		TypeParameter = "",
	}

	-- Basic
	cmp_config.completion = {
		completeopt = "menu,menuone,noinsert,noselect",
	}
	cmp_config.window.completion = cmp.config.window.bordered()

	-- Mapping
	cmp_config.mapping = lsp.defaults.cmp_mappings({
		["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-Space>"] = cmp.mapping.complete(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s", "c" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	})

	-- Formatting/Kind
	cmp_config.formatting.fields = { "kind", "abbr", "menu" }
	cmp_config.formatting.format = function(entry, vim_item)
		-- Kind icons
		vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
		vim_item.menu = ({
			nvim_lsp = "[LSP]",
			luasnip = "[Snippet]",
			buffer = "[Buffer]",
			path = "[Path]",
			emoji = "[Emoji]",
			cmdline = "[CMD]",
		})[entry.source.name]
		return vim_item
	end

	-- Sources
	table.insert(cmp_config.sources, { name = "emoji" })

	-- Setup
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
