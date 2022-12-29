local M = {
	"nvim-telescope/telescope.nvim",
	enabled = true,
	cmd = { "Telescope" },
}

function M.config()
	local telescope = require("telescope")
	local actions = require("telescope.actions")

	telescope.setup({
		defaults = {
			prompt_prefix = " > ",
			selection_caret = " ",
			path_display = { "smart" },

			mappings = {
				i = {
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,

					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,

					["<C-c>"] = actions.close,

					["<Down>"] = actions.move_selection_next,
					["<Up>"] = actions.move_selection_previous,

					["<CR>"] = actions.select_default,
					["<C-x>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,

					["<C-u>"] = actions.preview_scrolling_up,
					["<C-d>"] = actions.preview_scrolling_down,

					["<PageUp>"] = actions.results_scrolling_up,
					["<PageDown>"] = actions.results_scrolling_down,

					["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
					["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
					["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					["<C-l>"] = actions.complete_tag,
					["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
				},

				n = {
					["<esc>"] = actions.close,
					["<CR>"] = actions.select_default,
					["<C-x>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,

					["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
					["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
					["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

					["j"] = actions.move_selection_next,
					["k"] = actions.move_selection_previous,
					["H"] = actions.move_to_top,
					["M"] = actions.move_to_middle,
					["L"] = actions.move_to_bottom,

					["<Down>"] = actions.move_selection_next,
					["<Up>"] = actions.move_selection_previous,
					["gg"] = actions.move_to_top,
					["G"] = actions.move_to_bottom,

					["<C-u>"] = actions.preview_scrolling_up,
					["<C-d>"] = actions.preview_scrolling_down,

					["<PageUp>"] = actions.results_scrolling_up,
					["<PageDown>"] = actions.results_scrolling_down,

					["?"] = actions.which_key,
				},
			},
		},
		pickers = {},
		extensions = {},
	})
end

function M.init()
	local builtin = require("telescope.builtin")
	local function find_files(current_dir)
		current_dir = current_dir or false
		local opts = { results_title = vim.fn.expand("%:p:h") }
		if current_dir then
			opts.cwd = vim.fn.expand("%:p:h")
		end
		builtin.find_files(opts)
	end

	local function git_files()
		local ok, _ = pcall(builtin.git_files, {
			results_title = vim.fn
				.system("cd " .. vim.fn.expand("%:p:h") .. " && git rev-parse --show-toplevel")
				:gsub("\n", ""),
		})
		if not ok then
			print('Not in a git repository.')
		end
	end

	vim.keymap.set("n", "<leader>fd", function()
		find_files(true)
	end, {})
	vim.keymap.set("n", "<leader>ff", find_files, {})
	vim.keymap.set("n", "<leader>fg", git_files, {})
	vim.keymap.set("n", "<leader>fF", builtin.live_grep, {})
	vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
	vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
end

return M
