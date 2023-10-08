return {
	config = function()
	require("lint").linters_by_ft = {
		tex = {'chktex',},
	},

	vim.api.nvim_create_autocmd({"BufWritePost", "BufEnter", "BufWinEnter", "InsertLeave", "TextChanged"}, {
				pattern = {"*.tex", },
				callback = function()
				require("lint").try_lint()
				end,
			})
	end,
}
