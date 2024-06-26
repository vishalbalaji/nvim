return {
	"echasnovski/mini.pick",
	version = "*",
	cmd = "Pick",
	keys = {
		{
			"<leader>ff",
			function()
				-- MiniPick.builtin.files({}, { source = { cwd = vim.fn.expand("%:p:h") } })
				vim.cmd.Pick("files")
			end,
		},
		{
			"<leader>fF",
			function()
				MiniPick.builtin.grep_live()
			end,
		},
		{
			"<leader>fh",
			function()
				MiniPick.builtin.help()
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
		MiniPick.registry.files = function(local_opts)
			local command =
				{ "fd", "--type=f", "--no-follow", "--color=never", "--hidden", "-E.git", "-Enode_modules" }
			local show_with_icons = function(buf_id, items, query)
				return MiniPick.default_show(buf_id, items, query, { show_icons = true })
			end
			local source = { name = "Files", show = show_with_icons, cwd = local_opts.cwd }
			local_opts.cwd = nil
			return MiniPick.builtin.cli({ command = command }, { source = source })
		end
	end,
	dependencies = {
		require("config.devicons"),
	},
}
