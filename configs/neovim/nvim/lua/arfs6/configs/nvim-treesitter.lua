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
				"yaml",
			},
			sync_install = false,
			highlight = { enable = false },
			indent = { enable = true },
		})
	end,
}
