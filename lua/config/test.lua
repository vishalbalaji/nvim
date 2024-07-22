local function reduce(tbl, initial, f)
	for i, v in ipairs(tbl) do
		initial = f(v, initial, i)
	end
	return initial
end

local function get_tabs()
	return reduce(vim.api.nvim_list_tabpages(), {}, function(page, prev)
		local tab_name_index = #prev + 1
		local tab_name = ""

		prev[tab_name_index] = tab_name

		for i, win in ipairs(vim.api.nvim_tabpage_list_wins(page)) do
			local buf = vim.api.nvim_win_get_buf(win)
			if (vim.bo[buf] or {}).buflisted then
				local name = vim.api.nvim_buf_get_name(buf)

				if i == 1 then
					tab_name = name
				end

				prev[#prev + 1] = table.concat({
					"  ",
					name,
					vim.api.nvim_get_current_win() == win and " *" or "",
				})
			end
		end

		prev[tab_name_index] = tab_name
		return prev
	end)
end

return {
	name = "test",
	dir = "config.test",
	cmd = "Hello",
	config = function()
		vim.api.nvim_create_user_command("Hello", function()
			local buf = vim.api.nvim_create_buf(true, false)
			vim.bo[buf].buflisted = false
			vim.bo[buf].ft = "custom.tabs"
			vim.api.nvim_buf_set_name(buf, "tabs")

			local tabs = get_tabs()
			vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, tabs)
		end, {})
	end,
}
