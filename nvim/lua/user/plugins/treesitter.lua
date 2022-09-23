local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

local config = {}

-- Base-Level Settings
config.ensure_installed = "all" -- one of "all", "maintained" (parsers with maintainers), or a list of languages
config.ignore_install = { "phpdoc" }
config.sync_install = false -- install languages synchronously (only applied to `ensure_installed`)

-- TS Plugins
-- -- Autopairs
config.autopairs = {
	enable = true,
}

-- -- Highlight
config.highlight = {
	enable = true, -- false will disable the whole extension
	disable = { "" }, -- list of language that will be disabled
	additional_vim_regex_highlighting = true,
}

-- -- Indent
config.indent = { enable = true, disable = { "yaml", "python" } }

-- -- Context Commentstring
config.context_commentstring = {
	enable = true,
	enable_autocmd = false,
	config = {},
}

-- -- AutoTag
config.autotag = {
	enable = true,
}

-- -- Rainbow
config.rainbow = {
	enable = true,
	extended_mode = true,
	colors = {
		vim.g.terminal_color_1,
		vim.g.terminal_color_6,
		vim.g.terminal_color_3,
		vim.g.terminal_color_4,
		vim.g.terminal_color_5,
	},
	termcolors = {
		"Red",
		"Green",
		"Yellow",
		"Blue",
		"Magenta",
	},
}

configs.setup(config)
require("pretty-fold").setup({})

require("vim.treesitter.query").set_query(
	"markdown",
	"highlights",
	[[
;From MDeiml/tree-sitter-markdown
(atx_heading (inline) @text.title)
(setext_heading (paragraph) @text.title)
[
  (atx_h1_marker)
  (atx_h2_marker)
  (atx_h3_marker)
  (atx_h4_marker)
  (atx_h5_marker)
  (atx_h6_marker)
  (setext_h1_underline)
  (setext_h2_underline)
] @punctuation.special
[
  (link_title)
  (indented_code_block)
  (fenced_code_block)
] @text.literal
[
  (fenced_code_block_delimiter)
] @punctuation.delimiter
(code_fence_content) @none
[
  (link_destination)
] @text.uri
[
  (link_label)
] @text.reference
[
  (list_marker_plus)
  (list_marker_minus)
  (list_marker_star)
  (list_marker_dot)
  (list_marker_parenthesis)
  (thematic_break)
] @punctuation.special
[
  (block_continuation)
  (block_quote_marker)
] @punctuation.special
[
  (backslash_escape)
] @string.escape
]]
)
