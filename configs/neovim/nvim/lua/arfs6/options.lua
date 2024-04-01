local opt = vim.opt
opt.title = true
opt.ruler = false
opt.number = true
opt.relativenumber = true
opt.smartindent = true
opt.softtabstop = 8
opt.shiftwidth = 8
opt.colorcolumn = "80"
vim.cmd[[set clipboard+=unnamedplus]]
vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
        ['+'] = {'win32yank.exe', '-i', '--crlf'},
        ['*'] = {'win32yank.exe', '-i', '--crlf'},
    },
    paste = {
        ['+'] = {'win32yank.exe', '-o', '--lf'},
        ['*'] = {'win32yank.exe', '-o', '--lf'},
    },
    cache_enabled = 0,
}
-- opt.python3_host_prog = '/usr/bin/python3'
opt.cursorline = true
opt.cursorcolumn = true
opt.expandtab = false
opt.syntax = 'on'
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 9
opt.ruler = false-- indentation for js is 2 spaces
vim.cmd [[
  autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
]]
vim.g.netrw_liststyle = 3 -- Tree listing style for netrw
vim.cmd[[filetype plugin indent on]]
opt.showtabline = 1

opt.undofile = true

-- folds
opt.foldmethod = "expr"
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevelstart = 3
opt.termguicolors = true
opt.spell = true
opt.isfname:append("@-@")
opt.completeopt="menu,menuone,preview"
opt.pumwidth=9999
