local M = {
	"declancm/maximize.nvim",
	enabled = true,
	keys = { { "<C-m>", "<Cmd>lua require('maximize').toggle()<CR>" } },
}

M.config = function()
	require("maximize").setup({ default_keymaps = false })
end

return M
