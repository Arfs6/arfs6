local vim = vim
local set = vim.keymap.set
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({'i', 'v'}, 'jj', '<ESC>')
-- vim.keymap.set('n', ';', ':')
vim.keymap.set('t', 'jj', '<C-\\><C-n>')
vim.keymap.set('n', '<leader>tb', ':tabe | terminal bash<cr>')
vim.keymap.set('n', '<leader>t', ':tabe<cr>')
vim.keymap.set('n', '<leader>s', ':w<cr>')
vim.keymap.set({'n', 'x', 's'}, '<down>', 'gj')
vim.keymap.set({'n', 'x', 's'}, '<up>', 'gk')
vim.keymap.set("n", '<leader><leader>', "<cmd>w<cr>")
set('n', '<leader>.', '>>')
set('n', '<leader>,', '<<')
set('n', '<leader>mx', ':silent w | silent !chmod +x % <cr>')
set('n', '<leader>cn', '<cmd> cn <cr>')

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		--[[ vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts) ]]
		vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<leader>fm', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})
vim.keymap.set('n', '<leader>rp', function()
	package.loaded.keytones = nil
	require('keytones').setup()
end)
set('i', '<a-a>', '<c-x><c-o>')
set('n', '<leader>qo', '<cmd>copen<cr>')
