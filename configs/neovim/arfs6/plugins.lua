return {
	{
		'windwp/nvim-autopairs',
		lazy = false,
		config = true,
	},

	{
		'numToStr/Comment.nvim', -- Smart commenting
		lazy = false,
		config = true,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = require("arfs6.configs.nvim-treesitter").config,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		config = true,
		lazy = false,
	},

	{
    "ethanholz/nvim-lastplace",
    lazy = false,
    config = function()
    require("nvim-lastplace").setup({
        lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
        lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
        lastplace_open_folds = true})
    end,
  },

  {
	  "williamboman/mason.nvim",
	  lazy = false,
	  config = true,
  },

  {
	  "williamboman/mason-lspconfig.nvim",
	  config = require("arfs6.configs.mason_lsp_config").config,
	  lazy = false,
  },

	{
		"neovim/nvim-lspconfig",
		config = require"arfs6.configs.lsp_config".config,
		lazy = false,
	},

	--[[ {
		"lervag/vimtex",
	}, ]]

	{
		"L3MON4D3/LuaSnip",
		version = "2.*",
		build = "make install_jsregexp",
		lazy = false,
	},

	{
		"hrsh7th/nvim-cmp",
		lazy = false,
	},
}
