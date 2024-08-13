return { -- Autocompletion
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				-- Build Step is needed for regex support in snippets.
				-- This step is not supported in many windows environments.
				-- Remove the below condition to re-enable on windows.
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			dependencies = {
				-- `friendly-snippets` contains a variety of premade snippets.
				--    See the README about individual language/framework/plugin snippets:
				--    https://github.com/rafamadriz/friendly-snippets
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load({})
					end,
				},
			},
		},
		"saadparwaiz1/cmp_luasnip",

		-- Adds other completion capabilities.
		--  nvim-cmp does not ship with all sources by default. They are split
		--  into multiple repos for maintenance purposes.
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"UtkarshKunwar/cmp-emoji",
--		{
--			"hrsh7th/cmp-emoji",
--			url = "git@github.com:UtkarshKunwar/cmp-emoji.git",
--		},
	},
	config = function()
		-- See `:help cmp`
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		Config.util.hl("CmpGhostText", { link = "Comment", default = true })

		luasnip.config.setup({})
		luasnip.filetype_extend("all", { "loremipsum", "license" })

		local highlight_colors = require("nvim-highlight-colors")

		cmp.setup({
			window = {
				completion = cmp.config.window.bordered({
					winhighlight = "CursorLine:CursorLine",
				}),
				documentation = cmp.config.window.bordered(),
			},
			formatting = {
				expandable_indicator = true,
				fields = { "kind", "abbr", "menu" },
				format = function(entry, item)
					local color_item = highlight_colors.format(entry, { kind = item.kind })

					-- Kind icons
					item.kind = string.format("%s", Config.icons.kind[item.kind])
					item.menu = ({
						nvim_lsp = "[LSP]",
						luasnip = "[Snippet]",
						buffer = "[Buffer]",
						path = "[Path]",
						emoji = "[Emoji]",
						cmdline = "[CMD]",
					})[entry.source.name]

					if color_item.abbr_hl_group then
						item.kind_hl_group = color_item.abbr_hl_group
						item.kind = color_item.abbr
					end

					-- if entry.source.name == "nvim_lsp" then
					-- 	pcall(function()
					-- 		print()
					-- 		vim_item.menu = (i.ft[entry.source.source.client.name] .. " " or "") .. vim_item.menu
					-- 	end)
					-- end

					return item
				end,
			},

			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = { completeopt = "menu,menuone,noselect" },

			-- For an understanding of why these mappings were
			-- chosen, you will need to read `:help ins-completion`
			--
			-- No, but seriously. Please read `:help ins-completion`, it is really good!
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.config.disable,
				["<C-p>"] = cmp.config.disable,

				-- Select the next item
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
				-- Select the previous item
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

				-- Scroll the documentation window [b]ack / [f]orward
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),

				-- Accept the completion.
				--  This will auto-import if your LSP supports it.
				--  This will expand snippets if the LSP sent a snippet.
				["<CR>"] = cmp.mapping.confirm({ select = true }),

				-- If you prefer more traditional completion keymaps,
				-- you can uncomment the following lines
				--['<CR>'] = cmp.mapping.confirm { select = true },
				--['<Tab>'] = cmp.mapping.select_next_item(),
				--['<S-Tab>'] = cmp.mapping.select_prev_item(),

				-- Manually trigger a completion from nvim-cmp.
				--  Generally you don't need this, because nvim-cmp will display
				--  completions whenever it has completion options available.
				["<C-Space>"] = cmp.mapping.complete({
					reason = "manual",
				}),

				-- Think of <c-l> as moving to the right of your snippet expansion.
				--  So if you have a snippet that's like:
				--  function $name($args)
				--    $body
				--  end
				--
				-- <c-l> will move you to the right of each of the expansion locations.
				-- <c-h> is similar, except moving you backwards.
				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),

				-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
				--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "buffer" },
				{ name = "emoji", option = { insert = false } },
			},
			experimental = {
				ghost_text = {
					hl_group = "CmpGhostText",
				},
			},
		})

		cmp.setup.cmdline(":", {
			mapping = {
				["<Tab>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i", "c" }),
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
				["<Tab>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i", "c" }),
				["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
				["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
			},
			sources = {
				{ name = "buffer" },
			},
		})

		Config.util.mod_hl("CmpItemKind", { bg = "NONE" })

		Config.util.mod_hl("CmpItemAbbr", { bg = "NONE" })
		Config.util.mod_hl("CmpItemAbbrMatchFuzzy", { bg = "NONE" })
		Config.util.mod_hl("CmpItemAbbrMatch", { bg = "NONE" })
		Config.util.mod_hl("CmpItemAbbrDeprecated", { bg = "NONE" })
		Config.util.mod_hl("CmpItemAbbr", { bg = "NONE" })

		Config.util.mod_hl("CmpItemMenu", { bg = "NONE" })
	end,
}
