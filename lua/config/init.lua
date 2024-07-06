local function append_table(t1, t2)
	for i = 1, #t2 do
		t1[#t1 + 1] = t2[i]
	end
	return t1
end

local cmd = vim.api.nvim_create_user_command
local autocmd = vim.api.nvim_create_autocmd

---@param options ConfigOpts
local function setup(_, options)
	local wo = options.wo or {}
	options.wo = nil

	local bo = options.bo or {}
	options.bo = nil

	local opt = options.opt or {}
	options.opt = {}

	for key, value in pairs(opt) do
		vim.opt[key] = value
	end

	for key, value in pairs(wo) do
		vim.wo[key] = value
	end

	for key, value in pairs(bo) do
		vim.bo[key] = value
	end

	cmd("Q", "quitall!", {})
	cmd("E", "e!", {})
	cmd("W", "w! | e!", {})

	autocmd("VimEnter", {
		once = true,
		command = "set formatoptions-=cro",
	})

	autocmd("TextYankPost", {
		desc = "Highlight when yanking (copying) text",
		group = vim.api.nvim_create_augroup("custom-highlight-yank", { clear = true }),
		callback = function()
			vim.highlight.on_yank()
		end,
	})

	autocmd("FileType", {
		once = true,
		pattern = { "help", "qf" },
		callback = function()
			vim.keymap.set("n", "q", vim.cmd.quit, { noremap = true, silent = true })
		end,
	})

	if vim.env.TERM == "xterm-kitty" then
		autocmd({ "VimEnter" }, {
			once = true,
			callback = function()
				if vim.env.TERM == "xterm-kitty" then
					vim.fn.jobstart("kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=0", { detach = true })
					vim.api.nvim_create_user_command("KittyPadding", function()
						vim.fn.jobstart("kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=0", { detach = true })
					end, {})
					vim.keymap.set("n", "<M-S-r>", vim.cmd.KittyPadding, { noremap = true, silent = true })
				end
			end,
		})

		autocmd({ "VimLeave" }, {
			callback = function()
				if vim.env.TERM == "xterm-kitty" then
					vim.keymap.del("n", "<M-S-r>")
					vim.api.nvim_del_user_command("KittyPadding")
					vim.fn.jobstart("kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=10", { detach = true })
				end
			end,
		})
	end

	autocmd("FileType", {
		once = true,
		pattern = { "markdown", "gitcommit", "diff" },
		callback = function()
			if vim.bo.filetype == "diff" then
				vim.cmd("TSBufDisable highlight")
				vim.cmd("hi! link diffAdded DiffAdd")
				return
			end
			if vim.bo.filetype == "gitcommit" then
				vim.cmd("setlocal colorcolumn=80")
			elseif vim.bo.filetype == "markdown" then
				vim.cmd("setlocal wrap")
			end
			vim.cmd("setlocal spell")
		end,
	})
end

--- [BEGIN CONFIG] ---

local M = {
	name = "config",
	dir = "config",
	lazy = false,
	priority = 999,

	keys = function()
		---@type ConfigKeys
		local keys = {}

		return append_table(require("shared.keymaps"), keys)
	end,

	opts = function()
		---@type ConfigOpts
		local opts = {
			opt = {
				list = true,
				listchars = {
					lead = Config.icons.ui.MiddleDot,
					trail = Config.icons.ui.MiddleDot,
					tab = Config.icons.ui.LineMiddle .. " ",
					nbsp = Config.icons.ui.Nbsp,
				},

				fillchars = {
					foldopen = Config.icons.ui.ChevronShortDown,
					foldclose = Config.icons.ui.ChevronShortRight,
				},
			},
		}

		return vim.tbl_deep_extend("force", require("shared.opts"), opts)
	end,

	config = setup,
}

return M
