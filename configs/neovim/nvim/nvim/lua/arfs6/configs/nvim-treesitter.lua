return {
	config = function () 
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"css",
				"javascript",
				"html",
				"python",
				"json",
				"markdown",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },  
		})
	end,
}
