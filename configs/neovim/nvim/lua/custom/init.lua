-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

vim.g.mapleader = ','
vim.opt.title = true  -- Show title
vim.opt.smartindent = true
vim.opt.softtabstop = 8
vim.opt.shiftwidth = 8
--[ vim.opt.wildmode = 'longest,list' -- get bash-like tab completions --]
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.expandtab = false
vim.opt.syntax = 'on'
vim.opt.smartcase = true
vim.opt.scrolloff = 4
vim.opt.ruler = false
vim.opt.laststatus = 0
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

-- indentation for js is 2 spaces
vim.cmd [[
  autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
]]

				-- Yanky
-- Couldn't add mappings to mappings.lua file.
--]
vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")
vim.keymap.set({"n","x"}, "y", "<Plug>(YankyYank)")

vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")
vim.keymap.set('t', 'jj', '<C-\\><C-n>')
