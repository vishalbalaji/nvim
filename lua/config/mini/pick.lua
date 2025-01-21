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
				vim.cmd.Pick("files", "name='" .. vim.fn.getcwd() .. "'")
			end,
		},
		{
			"<leader>fp",
			function()
				local root_patterns = { ".git" }
				local dir =
					vim.fs.dirname(vim.fs.find(root_patterns, { upward = true, path = vim.fn.expand("%:p:h") })[1])
				vim.cmd.Pick("files", "cwd='" .. dir .. "'", "name='" .. dir .. "'")
			end,
		},
		{
			"<leader>fd",
			function()
				vim.cmd.Pick("files", "cwd='%:p:h'", "name='%:p:h'")
			end,
		},
		{
			"<leader>fF",
			function()
				vim.cmd.Pick("grep_live")
			end,
		},
		{
			"<leader>fb",
			function()
				vim.cmd.Pick("buffers")
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
			choose_marked = "<C-CR>",
		},
		window = {
			config = {
				border = { " " },
			},
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				Config.util.hl("MiniPickBorder", { link = "MiniPickNormal" })

				local border_hl = Config.util.get_hl("MiniPickBorder")
				local prompt_hl = Config.util.get_hl("MiniPickPrompt")

				Config.util.hl("MiniPickPrompt", { bg = border_hl.bg, fg = prompt_hl.fg })
			end,
		})
	end,
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
		--
		MiniPick.registry.files = function(local_opts)
			local show_with_icons = function(buf_id, items, query)
				return MiniPick.default_show(buf_id, items, query, { show_icons = true })
			end
			local source = { name = local_opts.name or "Files", show = show_with_icons, cwd = local_opts.cwd }
			local_opts.cwd = nil
			return MiniPick.builtin.cli({
				command = {
					"fd",
					"--type=f",
					"--color=never",
					"--no-follow",
					"--no-ignore",
					"--hidden",
					"-E.**/*",
					"-Enode_modules",
					"-E__pycache__",
				},
			}, { source = source })
		end

		MiniPick.registry.grep_live = function(local_opts)
			local _opts = { source = { cwd = local_opts.cwd } }
			local_opts.cwd = nil
			return MiniPick.builtin.grep_live(local_opts, _opts)
		end
	end,
}
