return {
	config = function()
		local cmp = require 'cmp'
		cmp.setup {
			snipet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end
			},
			sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'copilot' },
					{ name = 'luasnip' },
				},
				{
					{ name = 'buffer' },
				}),
			mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				['<C-Q>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<C-G>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
		}
	end
}
