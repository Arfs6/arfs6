return {
	keys = {
		'sa', 'sr', 'sd'
	},

	config = function()
		vim.g['sandwich#recipes'] = vim.fn.deepcopy(vim.g['sandwich#default_recipes'])
	end
}
