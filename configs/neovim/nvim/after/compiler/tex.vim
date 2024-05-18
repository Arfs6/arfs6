lua << eof
vim.bo.makeprg = string.sub(vim.bo.makeprg, 1, -26)
eof
