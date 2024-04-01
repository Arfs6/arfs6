return {
	config = function()
		local telescope = require 'telescope'
		telescope.setup {
			defaults = {
				sorting_strategy = 'ascending',
				prompt_prefix = '[telescope] ',
				layout_config = {
					width = 0.999,
					prompt_position = 'top',
				},
			},
		}
		telescope.load_extension('fzf')

		local set = vim.keymap.set
		set({ 'n', }, '<leader>ff', '<cmd> Telescope find_files <cr>')
		set({ 'n', }, '<leader>fh', '<cmd> Telescope help_tags <cr>')
		set({ 'n', }, '<leader>fz', '<cmd> Telescope current_buffer_fuzzy_find <cr>')
		set({'n'}, '<leader>fb', '<cmd> Telescope buffers <cr>')
	end,
	keys = {
		'<leader>ff',
		'<leader>fb',
		'<leader>fz',
		'<leader>fh',
	}
}
