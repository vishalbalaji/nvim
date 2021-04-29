require "lspconfig".pyright.setup {
  root_dir = vim.loop.cwd
}
-- require "lspconfig".pyls.setup {}

-- EFM Config
local python_arguments = {}

local flake8 = {
  -- LintCommand = "flake8 --ignore=E501 --stdin-display-name ${INPUT} -",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"}
}

local isort = {formatCommand = "isort --quiet -", formatStdin = true}

local yapf = {formatCommand = "yapf --quiet", formatStdin = true}
-- local black = {formatCommand = "black --quiet -", formatStdin = true}

table.insert(python_arguments, flake8)
table.insert(python_arguments, isort)
table.insert(python_arguments, yapf)

return python_arguments
