local M = {
	"luukvbaal/statuscol.nvim",
	enabled = true,
	event = "VeryLazy",
}

M.config = function()
	-- local builtin = require("statuscol.builtin")
	require("statuscol").setup({
		-- configuration goes here, for example:
		-- segments = {
		-- relculright = true,
		--   { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
		--   {
		--     sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
		--     click = "v:lua.ScSa"
		--   },
		--   { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
		--   {
		--     sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true },
		--     click = "v:lua.ScSa"
		--   },
		-- }
	})
end

return M
