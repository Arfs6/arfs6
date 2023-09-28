local createAutoCmd = vim.api.nvim_create_autocmd

createAutoCmd({ 'VimEnter', }, {
	callback = function()
		vim.schedule(function()
			vim.wait(2000, function()
				vim.cmd('LspStart')
				return vim.lsp.buf.server_ready()
			end)
		end)
	end
})
