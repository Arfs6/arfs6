return {
	config = function()
		local cmp = require'cmp'
		cmp.setup{
			snipet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
					end
			},
			       sources = cmp.config.sources({
					       { name = 'nvim_lsp' },
					       { name = 'luasnip' },
					       },
					       {
					       { name = 'buffer' },
					       })
		}
	end
}
