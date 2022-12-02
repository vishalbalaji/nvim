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
cmd("E", "w! | e!", {})

-- General Keymaps
map(
	"n",
	"gx",
	"<cmd>silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1) . ' & disown'<CR><cmd>echo 'Opening in browser...'<CR>",
	opts
)

map(
	"v",
	"gx",
	"<cmd>silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1) . ' & disown'<CR><cmd>echo 'Opening in browser...'<CR>",
	opts
)

map("n", "<F1>", "", opts)

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

-- -- Surround
map("v", '"', 'c"<Esc>pa"<Esc>v2i"', opts)
map("v", "'", "c'<Esc>pa'<Esc>v2i'", opts)
map("v", "`", "c`<Esc>pa`<Esc>v2i`", opts)
map("v", "(", "c(<Esc>pa)<Esc>va(", opts)
map("v", "[", "c[<Esc>pa]<Esc>va[", opts)
map("v", "{", "c{<Esc>pa}<Esc>va{", opts)
-- map("x", "<", "c<<Esc>pa><Esc>va<", opts)
map("v", "*", "c*<Esc>pa*<Esc>gvll", opts)

-- -- General Purpose
map("n", "<Esc>", "<Esc><cmd>noh<CR>", opts)
map("n", "<Tab>", "za", opts)
map("n", "<S-Tab>", "zA", opts)

-- -- Terminal
-- Better terminal navigation
map("t", "<C-Space>", "<Esc>i<C-\\><C-N><Esc>", term_opts)

-- -- Splits
local _, smart_splits = pcall(require, "smart-splits")

if not _ then
	return
end

map("n", "<C-s>", "<C-w>s", opts)
map("n", "<C-S-s>", "<C-w>v", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "<C-S-h>", smart_splits.resize_left, opts)
map("n", "<C-S-l>", smart_splits.resize_right, opts)
map("n", "<C-S-k>", smart_splits.resize_up, opts)
map("n", "<C-S-j>", smart_splits.resize_down, opts)
map("n", "<C-S-0>", "<C-w>=", opts)

-- -- Tabs
map("n", "<M-S-t>", "<cmd>tabnew<CR>", opts)
map("n", "<M-S-x>", "<cmd>Bdelete!<CR>", opts)
map("n", "<M-S-k>", "<Plug>(cokeline-focus-next)", opts)
map("n", "<M-S-j>", "<Plug>(cokeline-focus-prev)", opts)
map("n", "<M-S-l>", "<Plug>(cokeline-switch-next)", opts)
map("n", "<M-S-h>", "<Plug>(cokeline-switch-prev)", opts)

-- -- Splits
map("n", "<C-q>", "<C-w>q", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-S-h>", smart_splits.resize_left, opts)
map("n", "<C-S-l>", smart_splits.resize_right, opts)
map("n", "<C-S-k>", smart_splits.resize_up, opts)
map("n", "<C-S-j>", smart_splits.resize_down, opts)
map("n", "<C-S-0>", "<C-w>=", opts)

-- -- Comments
map("n", "<C-/>", "<Plug>(comment_toggle_linewise_current)", opts)
map("x", "<C-/>", "<Plug>(comment_toggle_linewise_visual)gv", opts)

-- LSP
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

-- -- Git
local _e, _ = pcall(require, "toggleterm.terminal")
if not _e then
	return
end

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	hidden = true,
	dir = "git_dir",
	direction = "float",
	float_opts = {
		border = "curved",
	},
	-- function to run on opening the terminal
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.opt_local.winbar = "  LazyGit"
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", opts)
	end,
	-- function to run on closing the terminal
	on_close = function(_)
		vim.cmd("echo 'Closing LazyGit'")
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

local _e1, _ = pcall(require, "telescope")

if not _e1 then
	return
end

local telescope_command = function(action, options)
	options = options or {}
	options.previewer = false

	local options_str = " " .. vim.inspect(options)
	options_str = options_str:gsub("\n", ""):gsub("\\s[1,]", " "):gsub("\\\\", "\\"):gsub("<Tab>", "'<Tab>'")

	local command = "lua require('telescope.builtin')."
		.. action
		.. "(require('telescope.themes').get_dropdown("
		.. options_str
		.. "))"

	command = "<cmd>" .. command:gsub('"', ""):gsub("\n", "") .. "<CR>"
	-- print(command)
	return command
end

local wk_config = require("user.plugins.whichkey")

local wk_n_mappings = {
	a = { "<cmd>AerialToggle<CR>", "Toggle Aerial" },
	c = { "<cmd>ColorizerToggle<CR>", "Toggle Colorizer" },
	d = { "<cmd>cd %:p:h<CR><cmd>pwd<CR>", "Switch CWD" },
	e = {
		"<cmd>silent! NvimTreeToggle<CR>",
		"Explorer",
	},
	f = {
		name = "Telescope",
		d = {
			telescope_command(
				"find_files",
				{ cwd = "vim.fn.expand('%:p:h')", results_title = "vim.fn.expand('%:p:h')" }
			),
			"Find in CWD",
		},
		f = {
			telescope_command("find_files", { results_title = "vim.fn.expand('%:p:h')" }),
			"Find files",
		},
		F = { "<cmd>Telescope live_grep theme=ivy<CR>", "Find Text" },
		g = {
			telescope_command("git_files", {
				cwd = "vim.fn.expand('%:p:h')",
				results_title = "vim.fn.system('cd ' .. vim.fn.expand('%:p:h') .. ' && git rev-parse --show-toplevel'):gsub('\n', '')",
			}),
			"Find Git files",
		},
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
		h = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Open Float" },
		i = { "<cmd>LspInfo<CR>", "Info" },
		m = { "<cmd>Mason<CR>", "Open Mason" },
		n = { "<cmd>NullLsInfo<CR>", "NullLs Info" },
		r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
		R = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
		s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "References" },
		t = {
			function()
				vim.cmd([[ TroubleToggle workspace_diagnostics ]])
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
	t = {
		name = "Terminal",
		t = {
			function()
				vim.cmd("ToggleTerm")
				local termBuffer = vim.api.nvim_exec([[ echo win_getid(winnr('$')) ]], true)
				if require("nvim-tree.view").is_visible() then
					vim.cmd([[ NvimTreeClose ]])
					vim.cmd([[ NvimTreeOpen ]])
				end
				vim.cmd("call win_gotoid(" .. termBuffer .. ")")
			end,
			"Toggle Terminal",
		},
		d = {
			[[<cmd>TermExec cmd='cd %:p:h' go_back=0<CR>i<CR>]],
			"CD to directory in Terminal",
		},
	},
	v = { '""p', "Paste from Default Register" },
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
	y = { '""y', "Copy to Default Register" },
}

wk_n_mappings.h = {
	name = "Harpoon",
	a = { "<cmd>lua require('harpoon.mark').add_file()<CR><cmd>echo 'harpoon: Mark added'<CR>", "Add mark" },
	h = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Toggle" },
	n = { "<cmd>lua require('harpoon.ui').nav_next()<CR>", "Next" },
	p = { "<cmd>lua require('harpoon.ui').nav_prev()<CR>", "Previous" },
}

for i = 1, 5 do
	wk_n_mappings.h[tostring(i)] = { "<cmd>lua require('harpoon.ui').nav_file(" .. i .. ")<CR>", "Goto mark " .. i }
end

which_key.setup(wk_config.setup)
which_key.register(wk_n_mappings, wk_config.nopts)
which_key.register(wk_v_mappings, wk_config.vopts)
