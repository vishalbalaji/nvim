local M = {
	"akinsho/toggleterm.nvim",
	enabled = true,
	event = "VeryLazy",
}

M.config = function()
	local toggleterm = require("toggleterm")

	toggleterm.setup({
		shell = "EMACS_BINDING=true /usr/bin/zsh",
		shade_terminals = false,
		start_in_insert = false,
		auto_scroll = false,
		on_open = function(term)
			vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
		end,
	})

	local Terminal = require("toggleterm.terminal").Terminal
	local lazygit = Terminal:new({
		cmd = "lazygit",
		dir = "git_dir",
		direction = "float",
		float_opts = {
			border = "rounded",
		},
		-- function to run on opening the terminal
		on_open = function(term)
			vim.cmd("startinsert!")
			vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
		end,
		-- function to run on closing the terminal
		on_close = function()
			vim.cmd("startinsert!")
		end,
	})

	local function _lazygit_toggle()
		lazygit:toggle()
	end

	local map = require("config.keymaps")

	map("n", "<leader>g", _lazygit_toggle)
	map("n", "<leader>t", "<cmd>ToggleTerm<CR><C-\\><C-n>")
end

return M
