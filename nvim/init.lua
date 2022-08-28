-- impatient.nvim: https://github.com/lewis6991/impatient.nvim
require('impatient')

-- General
require("user.autocommands")
require("user.colorscheme")
require("user.keymaps_commands")
require("user.options")
require("user.plugins")

-- Plugins
require("user.plugins.dressing")
require("user.plugins.cokeline")
require("user.plugins.impatient")
require("user.plugins.lualine")
require("user.plugins.mini")
require("user.plugins.navic")
require("user.plugins.nvim-tree")
require("user.plugins.telescope")
require("user.plugins.treesitter")
require("user.plugins.ufo")
require("user.plugins.winbar")

-- LSP
require("user.lsp")
require("user.lsp.cmp")
