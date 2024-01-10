local m = {}

m.config = function()
	local select = {
		enable = true,
		lookahead = true, -- Auto jump to text object
		keymaps = {
			["af"] = "@function.outer",
			["if"] = "@function.inner",
			["ac"] = "@class.outer",
			["ic"] = "@class.inner",
		},
	}

	require "nvim-treesitter.configs".setup {
		textobjects = {
			select = select,
		},
	}
end

return m
