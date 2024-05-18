local m = {}

m.config = function()
	require("oil").setup({
		default_file_explorer = false,
	})
	vim.keymap.set("n", "<leader>oo", "<cmd>Oil .<cr>")
end

return m
