vim.opt.title = true
vim.opt.ruler = false
vim.opt.number = true
vim.opt.smartindent = true
vim.opt.softtabstop = 8
vim.opt.shiftwidth = 8
vim.opt.colorcolumn = "80"
vim.api.nvim_create_autocmd('vimenter', {
	callback = function()
		vim.schedule(function()
			vim.opt.clipboard = "unnamedplus" -- Sync system clipboard with vim's clipboard
	end)
	end
})
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.expandtab = false
vim.opt.syntax = 'on'
vim.opt.smartcase = true
vim.opt.scrolloff = 4
vim.opt.ruler = false-- indentation for js is 2 spaces
vim.cmd [[
  autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
]]
vim.g.netrw_liststyle = 3 -- Tree listing style for netrw
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.foldexpr = "nvim_treesitter"
vim.cmd[[filetype plugin indent on]]
vim.opt.showtabline = 1

-- indent line plugin config
vim.g.indentLine_char = '|'
