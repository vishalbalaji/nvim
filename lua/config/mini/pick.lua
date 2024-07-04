return {
	"echasnovski/mini.pick",
	version = "*",
	dependencies = {
		require("config.devicons"),
	},
	cmd = "Pick",
	keys = {
		{
			"<leader>ff",
			function()
				vim.cmd.Pick("files")
			end,
		},
		{
			"<leader>fF",
			function()
				vim.cmd.Pick("grep_live")
			end,
		},
		{
			"<leader>fh",
			function()
				vim.cmd.Pick("help")
			end,
		},
	},
	opts = {
		mappings = {
			move_down = "<C-j>",
			move_up = "<C-k>",
		},
	},
	config = function(_, opts)
		require("mini.pick").setup(opts)
		-- vim.schedule(function()
		-- 	---@type string
		-- 	local highlights = vim.api.nvim_exec2("hi", { output = true }).output
		-- 	print(vim.inspect(highlights))

		-- 	-- MiniPick.registry.tmp = function(local_opts)
		-- 	-- 	vim.schedule(function()
		-- 	-- 	end)
		-- 	-- 	return MiniPick.start({ source = { items = { "foo", "bar", "baz" } } })
		-- 	-- end
		-- end)

		MiniPick.registry.files = function(local_opts)
			local command = { "fd", "--type=f", "--no-follow", "--color=never", "--hidden", "-E.git", "-Enode_modules" }
			local show_with_icons = function(buf_id, items, query)
				return MiniPick.default_show(buf_id, items, query, { show_icons = true })
			end
			local source = { name = "Files", show = show_with_icons, cwd = local_opts.cwd }
			local_opts.cwd = nil
			return MiniPick.builtin.cli({ command = command }, { source = source })
		end
	end,
}
