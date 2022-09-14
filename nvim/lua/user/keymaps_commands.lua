local map = vim.keymap.set
local cmd = vim.api.nvim_create_user_command

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Remap space as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Commands
cmd("Q", "quitall!", {})

-- General Keymaps
map("n", "gx", "<cmd>silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>", opts)
map("v", "gx", "<cmd>silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>", opts)

-- -- Move text up and down
map("n", "<A-h>", "<Plug>GoNSMLeft", opts)
map("n", "<A-j>", "<Plug>GoNSMDown", opts)
map("n", "<A-k>", "<Plug>GoNSMUp", opts)
map("n", "<A-l>", "<Plug>GoNSMRight", opts)
map("x", "<A-h>", "<Plug>GoVSMLeft", opts)
map("x", "<A-j>", "<Plug>GoVSMDown", opts)
map("x", "<A-k>", "<Plug>GoVSMUp", opts)
map("x", "<A-l>", "<Plug>GoVSMRight", opts)

-- -- Indent
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
map("v", "$", "$h", opts)

-- -- Surround
map("v", '"', 'c"<Esc>pa"<Esc>v2i"', opts)
map("v", "'", "c'<Esc>pa'<Esc>v2i'", opts)
map("v", "`", "c`<Esc>pa`<Esc>v2i`", opts)
map("v", "(", "c(<Esc>pa)<Esc>va(", opts)
map("v", "[", "c[<Esc>pa]<Esc>va[", opts)
map("v", "{", "c{<Esc>pa}<Esc>va{", opts)
map("v", "*", "c*<Esc>pa*<Esc>gvll", opts)

-- -- General Purpose
map("n", "<Esc>", "<Esc><cmd>noh<CR>", opts)
map("n", "<Tab>", "za", opts)

-- -- Terminal
-- Better terminal navigation
map("t", "<leader><Esc>", "<C-\\><C-N><Esc>", term_opts)

-- -- Splits
local _, smart_splits = pcall(require, "smart-splits")
if not _ then
	return
end

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "<C-S-h>", smart_splits.resize_left, opts)
map("n", "<C-S-l>", smart_splits.resize_right, opts)
map("n", "<C-S-k>", smart_splits.resize_up, opts)
map("n", "<C-S-j>", smart_splits.resize_down, opts)

-- -- Buffers/Tabs
local function closeBuf()
	local min_splits = 1
	if require("nvim-tree.view").is_visible() then
		min_splits = min_splits + 1
	end

	local troubleOpen = tonumber(vim.api.nvim_command_output([[echo bufwinid('Trouble')]]))

	if troubleOpen ~= -1 then
		min_splits = min_splits + 1
	end

	if #vim.api.nvim_tabpage_list_wins(0) > min_splits then
		vim.cmd([[ call feedkeys("\<C-w>q") ]])
	else
		vim.cmd([[ Bdelete! ]])
	end
end

map("n", "<A-S-k>", "<Plug>(cokeline-focus-next)", opts)
map("n", "<A-S-j>", "<Plug>(cokeline-focus-prev)", opts)
map("n", "<A-S-l>", "<Plug>(cokeline-switch-next)", opts)
map("n", "<A-S-h>", "<Plug>(cokeline-switch-prev)", opts)
map("n", "<A-S-f>", "<Plug>(cokeline-pick-focus)", opts)
map("n", "<A-S-t>", "<cmd>tabnew<CR>", opts)
map("n", "<A-S-r>", "<cmd>tabnew#<CR>", opts)
map("n", "<A-S-s>", "<cmd>split<CR>", opts)
map("n", "<A-S-v>", "<cmd>vsplit<CR>", opts)
map("n", "<A-S-x>", closeBuf, opts)

-- -- Comments
vim.api.nvim_set_keymap("n", "<C-/>", "gcc", term_opts)
vim.api.nvim_set_keymap("v", "<C-/>", "gcgv", term_opts)

-- -- Git
local _e, _ = pcall(require, "toggleterm.terminal")
if not _e then
	return
end

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	dir = "git_dir",
	direction = "float",
	float_opts = {
		border = "curved",
	},
	-- function to run on opening the terminal
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
	end,
	-- function to run on closing the terminal
	on_close = function(_)
		vim.cmd("echo 'Closing terminal'")
	end,
})

local function _lazygit_toggle()
	lazygit:toggle()
end

-- WhichKey Keymaps (prefixed with <leader>)
local _, which_key = pcall(require, "which-key")
if not _ then
	return
end

local wk_config = require("user.plugins.whichkey")

local wk_n_mappings = {
	d = { "<cmd>cd %:p:h<CR><cmd>pwd<CR>", "Switch CWD" },
	e = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
	f = {
		name = "Telescope",
		b = {
			"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>",
			"Find Buffers",
		},
		d = {
			"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false, cwd = vim.fn.expand('%:p:h'), results_title = vim.fn.expand('%:p:h')})<CR>",
			"Find in CWD",
		},
		f = {
			"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false, results_title = vim.fn.getcwd()})<CR>",
			"Find files",
		},
		F = { "<cmd>Telescope live_grep theme=ivy<CR>", "Find Text" },
	},
	g = {
		_lazygit_toggle,
		"LazyGit",
	},
	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
		d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
		f = { "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", "Format" },
		F = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Open Float" },
		h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
		i = { "<cmd>LspInfo<CR>", "Info" },
		l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
		r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
		R = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
		s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
		t = {
			function()
				vim.cmd([[ TroubleToggle ]])
				local troubleBuffer = vim.api.nvim_exec([[ echo win_getid(winnr('$')) ]], true)
				if require("nvim-tree.view").is_visible() then
					vim.cmd([[ NvimTreeClose ]])
					vim.cmd([[ NvimTreeOpen ]])
				end
				vim.cmd("call win_gotoid(" .. troubleBuffer .. ")")
			end,
			"Toggle Trouble",
		},
	},
	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<CR>", "Compile" },
		i = { "<cmd>PackerInstall<CR>", "Install" },
		r = { "<cmd>PackerClean<CR>", "Clean" },
		s = { "<cmd>PackerSync<CR>", "Sync" },
		S = { "<cmd>PackerStatus<CR>", "Status" },
		u = { "<cmd>PackerUpdate<CR>", "Update" },
	},
}

local wk_v_mappings = {
	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
		h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
		i = { "<cmd>LspInfo<CR>", "Info" },
		l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
		t = { "<cmd>TroubleToggle<CR>", "Toggle Trouble" },
	},
}

which_key.setup(wk_config.setup)
which_key.register(wk_n_mappings, wk_config.nopts)
which_key.register(wk_v_mappings, wk_config.vopts)