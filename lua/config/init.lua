local function append_table(t1, t2)
	for i = 1, #t2 do
		t1[#t1 + 1] = t2[i]
	end
	return t1
end

local cmd = vim.api.nvim_create_user_command
local autocmd = vim.api.nvim_create_autocmd

---@param options BasicOpts
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

	Config.hl("WinSeparator", { link = "NonText" })
	Config.hl("FoldColumn", { link = "NonText" })
	Config.hl("LineNr", { link = "NonText" })
	Config.hl("CursorLineNr", { link = "SpecialComment" })

	Config.hl("SpellBad", { link = "DiagnosticUnderlineError" })

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

local tmp = {
	-- Sensible defaults
	{ "<Esc>", "<cmd>nohlsearch<CR>" },
	{ "<Tab>", "za" },
	{ "<C-p>", "<Nop>", mode = { "i", "s" } },
	{ "<C-n>", "<Nop>", mode = { "i", "s" } },
	{ "Q", "<Nop>" },

	-- Utils
	{ "<leader>d", "<cmd>cd %:p:h<CR><cmd>pwd<CR>", desc = "Current [D]irectory" },
	{ "<leader>m", vim.cmd.messages, desc = "[M]essages" },

	-- Windows/Splits
	-- { "<C-w>", wincmd("q"), desc = "Close the window" },
	-- { "<C-h>", wincmd("h"), desc = "Move focus to the left window" },
	-- { "<C-l>", wincmd("l"), desc = "Move focus to the right window" },
	-- { "<C-j>", wincmd("j"), desc = "Move focus to the lower window" },
	-- { "<C-k>", wincmd("k"), desc = "Move focus to the upper window" },
	-- { "<C-S-0>", wincmd("="), desc = "Make window sizes equal" },
	-- { "<C-CR>", wincmd("s"), desc = "Create horizontal split" },
	-- { "<C-S-CR>", wincmd("v"), desc = "Create vertical split" },

	-- Clipboard
	{ "p", '"_dP', mode = "v" },
	{ "d", '"_d', mode = "v" },
	{ "c", '"_c', mode = "v" },

	{ "d", '"_d', mode = "n" },
	{ "c", '"_c', mode = "n" },
	{ "s", '"_s', mode = "n" },
	{ "r", '"_r', mode = "n" },

	{ "xx", "Vd", mode = "n" },
	{ "x", "d", mode = "n" },

	{ "s", '"_s', mode = "x" },
	{ "r", '"_r', mode = "x" },

	-- Maintain Cursor Position
	-- { "J", "mzJ`z" },
	-- { "<C-d>", "<C-d>zz" },
	-- { "<C-u>", "<C-u>zz" },
	-- { "n", "nzzzv" },
	-- { "N", "Nzzzv" },

	-- Visual Search
	-- { "/", visual_hl_search, mode = "v" },
}

local M = {
	name = "basic",
	dir = "",
	lazy = false,
	priority = 999,
	keys = function()
		---@type BasicKeys
		local keys = {}

		return append_table(require("shared.keymaps"), keys)
	end,

	opts = function()
		---@type BasicOpts
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
