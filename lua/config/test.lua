local files = {}

return {
	name = "test",
	dir = "config.test",
	cmd = "Hello",
	config = function()
		vim.api.nvim_create_user_command("Hello", function()
			local buf = vim.api.nvim_create_buf(true, false)
			vim.bo[buf].buflisted = false

			vim.api.nvim_create_autocmd("BufWriteCmd", {
				buffer = buf,
				nested = true,
				callback = function(args)
					print(vim.inspect(args))
					local lines = vim.api.nvim_buf_get_lines(buf, 0, vim.api.nvim_buf_line_count(buf), true)
					print(vim.inspect(files))
					print(vim.inspect(lines))
				end,
			})

			files = vim.split(vim.fn.glob("**/*"), "\n")
			vim.api.nvim_buf_set_name(buf, "hello-files")

			vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, files)

			vim.api.nvim_set_current_buf(buf)
		end, {})
	end,
}
