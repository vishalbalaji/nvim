local M = {
	"hrsh7th/nvim-cmp",
	enabled = true,
	event = "VeryLazy",

	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-emoji",
		'saadparwaiz1/cmp_luasnip',

		require("config.plugins.lsp.luasnip"),
	},
}

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

M.config = function()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local compare = cmp.config.compare

	vim.opt.completeopt = "menu,menuone"

	local config = {}
	local cmp_select = { behavior = cmp.SelectBehavior.Select }

	config.snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	}

	config.mapping = {
		["<C-Space>"] = cmp.mapping.complete({ reason = 'manual' }),
		["<C-e>"]     = cmp.mapping.abort(),
		["<C-k>"]     = cmp.mapping.select_prev_item(cmp_select),
		["<C-j>"]     = cmp.mapping.select_next_item(cmp_select),
		["<C-p>"]     = cmp.mapping.select_prev_item(),
		["<C-n>"]     = cmp.mapping.select_next_item(),
		["<CR>"]      = cmp.mapping.confirm(),
	}

	config.sorting =  {
    comparators = {
      compare.offset,
      compare.exact,
      compare.score,
      compare.recently_used,
      compare.locality,
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  }

	config.window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	}

	config.formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
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
		end,
	}

	config.sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "emoji", insert = false },
	})


	-- Setup
	cmp.setup(config)
	cmp.setup.cmdline(":", {
		mapping = {
			["<Tab>"] = cmp.mapping(cmp.mapping.confirm(), { "i", "c" }),
			["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
			["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
		},
		sources = {
			{ name = "cmdline" },
			{ name = "path" },
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
