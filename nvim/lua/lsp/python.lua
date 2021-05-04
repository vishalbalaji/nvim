require "lspconfig".pyright.setup {}
-- require "lspconfig".pyls.setup {
-- 	cmd = {'/home/vishal/.local/bin//pyls'}
-- }

-- EFM Config
local python_arguments = {}

-- local flake8 = {
--   LintCommand = "flake8 --ignore=E501 --stdin-display-name ${INPUT} -",
--   lintStdin = true,
--   lintFormats = {"%f:%l:%c: %m"}
-- }
-- table.insert(python_arguments, flake8)

local isort = {formatCommand = "isort --quiet -", formatStdin = true}
local yapf = {formatCommand = "yapf --quiet", formatStdin = true}
-- local black = {formatCommand = "/home/vishal/.local/bin//black --quiet -", formatStdin = true}

table.insert(python_arguments, yapf)
table.insert(python_arguments, isort)

return python_arguments
