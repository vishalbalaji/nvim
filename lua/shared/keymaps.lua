---@alias BasicKeys LazyKeysSpec[]

local cr_termcode = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
local function visual_hl_search()
	vim.opt.lazyredraw = true

	local special_characters = { "~", "/", "%." }

	vim.fn.execute('normal! "sy')
	local pattern = vim.inspect(vim.fn.getreg("s"))

	pattern = string.sub(pattern, 2, string.len(pattern) - 1)
	for _, char in pairs(special_characters) do
		pattern = string.gsub(pattern, char, "\\" .. char)
	end

	vim.api.nvim_feedkeys("/" .. pattern .. cr_termcode .. "N", "n", false)
	vim.opt.lazyredraw = false
end

local wincmd = function(char)
	return function()
		vim.cmd.wincmd(char)
	end
end

---@type BasicKeys
return {
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
	{ "<C-w>", wincmd("q"), desc = "Close the window" },
	{ "<C-h>", wincmd("h"), desc = "Move focus to the left window" },
	{ "<C-l>", wincmd("l"), desc = "Move focus to the right window" },
	{ "<C-j>", wincmd("j"), desc = "Move focus to the lower window" },
	{ "<C-k>", wincmd("k"), desc = "Move focus to the upper window" },
	{ "<C-S-0>", wincmd("="), desc = "Make window sizes equal" },
	{ "<C-CR>", wincmd("s"), desc = "Create horizontal split" },
	{ "<C-S-CR>", wincmd("v"), desc = "Create vertical split" },

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
	{ "J", "mzJ`z" },
	{ "<C-d>", "<C-d>zz" },
	{ "<C-u>", "<C-u>zz" },
	{ "n", "nzzzv" },
	{ "N", "Nzzzv" },

	-- Visual Search
	{ "/", visual_hl_search, mode = "v" },
}
