return {
	{
		"folke/neoconf.nvim",
		config = true,
		lazy = false,
		enabled = false,
	},

	{
		"folke/neodev.nvim",
		config = true,
		lazy = false,
	},

	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = require'arfs6.configs.autopairs'.config,
	},

	{
		'numToStr/Comment.nvim', -- Smart commenting
		lazy = false,
		config = true,
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
			"nvim-treesitter/nvim-treesitter",
			build = function()
				require("nvim-treesitter.install").update({ with_sync = true })
			end,
			config = require("arfs6.configs.nvim-treesitter").config,
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

		{
		"lervag/vimtex",
		ft = "tex",
		},

		{
			"L3MON4D3/LuaSnip",
			version = "2.*",
			config = require'arfs6.configs.luasnip'.config,
			build = "make install_jsregexp",
			event = "InsertEnter",
			dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()end,
		},
		},

		{
			"hrsh7th/nvim-cmp",
			config = require'arfs6.configs.cmp'.config,
			event = "InsertEnter",
			dependencies = {
				{
					'hrsh7th/cmp-buffer',
				},
				{
					'saadparwaiz1/cmp_luasnip',
					config = true,
				},
			},
		},

		{
			"NvChad/nvterm",
			config = require "arfs6.configs.nvterm".config,
			keys = require "arfs6.configs.nvterm".keys,
		},

		{
			'mfussenegger/nvim-lint',
			event = 'BufEnter',
			config = require("arfs6.configs.nvim-lint").config
		},

		{
			"https://github.com/machakann/vim-sandwich",
			keys = require("arfs6.configs/sandwich").keys,
			config = require("arfs6.configs/sandwich").config
		},

		{
			"arfs6/keytones.nvim",
			dir = "~/proj/nvim/keytones.nvim",
			lazy = false,
			config = true,
		},
	c}
