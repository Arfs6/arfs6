local m = {}

--[[
--m.config - Set keymaps for Scrap Paper.
--]]
m.config = function()
	vim.keymap.set('n', '<leader>sc', '<cmd>ScrapPaper swap<cr>')
end

return m
