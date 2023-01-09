local M = {
	"mbbill/undotree",
	enabled = true,
	cmd = "UndotreeToggle",
	cond = function()
		local exclude_filetypes = { "man" }
		return not vim.tbl_contains(exclude_filetypes, vim.bo.filetype)
	end,
}
M.init = function()
	vim.keymap.set("n", "<leader>u", function()
		pcall(vim.cmd.UndotreeToggle)
	end, { desc = "Undotree", silent = true, noremap = true })
end

M.config = function()
	vim.cmd([[
if has("persistent_undo")
   let target_path = expand('~/.cache/nvim/undodir')
    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif
    let &undodir=target_path
    set undofile
endif
]])
end

return M
