return {
	keys = {
		{'sa', nil, {'n', 'v', 'x'}},
		{'sr', nil, {'n', 'v', 'x'}},
		{'sd', nil, {'n', 'v', 'x'}},
	},

	config = function()
		vim.g['sandwich#recipes'] = vim.fn.deepcopy(vim.g['sandwich#default_recipes'])
	end
}
