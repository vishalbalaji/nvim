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
-- -- Move text up and down
map("n", "<A-j>", "<Esc>:m .+1<CR>", opts)
map("n", "<A-k>", "<Esc>:m .-2<CR>", opts)
map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
map("n", "gx", "<cmd>silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>", opts)

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

-- WhichKey Keymaps (prefixed with <leader>)
local _, which_key = pcall(require, "which-key")
if not _ then
  return
end

local wk_config = require("user.plugins.whichkey")

local wk_mappings = {
  d = { "<cmd>cd %:p:h<CR><cmd>pwd<CR>", "Switch CWD" },
  e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  f = {
    name = "Telescope",
    b = {
      "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Find Buffers",
    },
    f = {
      "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Find files",
    },
    F = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
  },
  g = {
    name = "Git",
    c = { "<cmd>G commit<CR>", "Commit" },
    g = { "<cmd>G<CR>", "Commit" },
    p = { "<cmd>G push<CR>", "Commit" },
  },
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
    f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
    h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    R = { "<cmd>lua vim.lsp.buf.references()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    t = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
  },
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    r = { "<cmd>PackerClean<cr>", "Clean" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
}

which_key.setup(wk_config.setup)
which_key.register(wk_mappings, wk_config.opts)
