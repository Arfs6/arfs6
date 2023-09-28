local opt = vim.opt
opt.title = true
opt.ruler = false
opt.number = true
opt.smartindent = true
opt.softtabstop = 8
opt.shiftwidth = 8
opt.colorcolumn = "80"
vim.api.nvim_create_autocmd('vimenter', {
	callback = function()
		vim.schedule(function()
			opt.clipboard = "unnamedplus" -- Sync system clipboard with vim's clipboard
	end)
	end
})
opt.cursorline = true
opt.cursorcolumn = true
opt.expandtab = false
opt.syntax = 'on'
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 4
opt.ruler = false-- indentation for js is 2 spaces
vim.cmd [[
  autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
]]
vim.g.netrw_liststyle = 3 -- Tree listing style for netrw
opt.foldmethod = "indent"
opt.foldenable = false
opt.foldexpr = "nvim_treesitter"
vim.cmd[[filetype plugin indent on]]
opt.showtabline = 1

-- indent line plugin config
vim.g.indentLine_char = '|'
opt.undofile = true

-- folds
opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevelstart = 1
