require'lspconfig'.tsserver.setup{
	root_dir = vim.loop.cwd
}

-- EFM Settings
local tsserver_args = {}

local prettier = {formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true}

local eslint = {
	lintCommand = "eslint -f unix --stdin --stdin-filename ${INPUT}",
	lintIgnoreExitCode = true,
	lintStdin = true,
	lintFormats = {"%f:%l:%c: %m"},
	formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
	formatStdin = true
}

table.insert(tsserver_args, eslint)

return {
	tsserver_args = tsserver_args,
	prettier = prettier
}

-- return function() return tsserver_args, prettier end
