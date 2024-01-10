local m = {}

m.config = function()
	vim.keymap.set({ 'n', 'x' }, 'p', require('pasta.mappings').p)
	vim.keymap.set({ 'n', 'x' }, 'P', require('pasta.mappings').P)
	require('pasta').config.next_key = vim.api.nvim_replace_termcodes('<C-n>', true, true, false)
	require('pasta').config.prev_key = vim.api.nvim_replace_termcodes('<C-p>', true, true, false)
	require('pasta').config.indent_fix = true
end

return m

