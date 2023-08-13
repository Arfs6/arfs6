return {
	config = function()
		require "nvterm".setup()
		vim.keymap.set({'v', 't'}, '<A-h>', function()
			require("nvterm.terminal").toggle "horizontal"
		end)
	end,
	keys = {
		{'<A-h>', function()
			require("nvterm.terminal").toggle "horizontal"
		end},
	},
}
