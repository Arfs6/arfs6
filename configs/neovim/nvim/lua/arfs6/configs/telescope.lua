return {
	config = function()
		local telescope = require'telescope'
		telescope.setup{
			defaults = {
				sorting_strategy = 'ascending',
				prompt_prefix = '[telescope]',
				layout_config = {
					width = 0.999,
					prompt_position = 'top',
				},
			},
		}
		telescope.load_extension('fzf')
	end
}
