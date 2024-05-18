return {
	{
		"nvim-lua/plenary.nvim",
	},

	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		config = require 'arfs6.configs.telescope'.config,
		keys = require 'arfs6.configs.telescope'.keys,
		cmd = 'Telescope',
		enabled = true,
		dependencies = {
			'nvim-telescope/telescope-fzf-native.nvim',
			build =
			'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
		},
	},

	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = require 'arfs6.configs.autopairs'.config,
		enabled = true,
	},

	{
		'numToStr/Comment.nvim', -- Smart commenting
		lazy = false,
		config = true,
		enabled = true,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		config = require "arfs6.configs.indent-blankline".config,
		event = "VeryLazy",
		enabled = true,
	},

	{
		"ethanholz/nvim-lastplace",
		lazy = false,
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
				lastplace_open_folds = true
			})
		end,
		enabled = true,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = require("arfs6.configs.nvim-treesitter").config,
		event = { "VeryLazy" },
		enabled = true,
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				config = require 'arfs6.configs.nvim-treesitter-textobjects'.config,
			},
		}
	},

	{
		"williamboman/mason.nvim",
		lazy = false,
		enabled = true,
		config = true,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		config = require("arfs6.configs.mason_lsp_config").config,
		lazy = false,
		enabled = true,
	},

	{
		"L3MON4D3/LuaSnip",
		version = "2.*",
		config = require 'arfs6.configs.lua_snip'.config,
		build = "make install_jsregexp",
		event = "InsertEnter",
		enabled = true,
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = false,
		},
	},

	{
		"hrsh7th/nvim-cmp",
		config = require 'arfs6.configs.cmp'.config,
		event = "InsertEnter",
		enabled = true,
		dependencies = {
			{
				'hrsh7th/cmp-buffer',
			},
			{
				'saadparwaiz1/cmp_luasnip',
			},
			{
				'hrsh7th/cmp-nvim-lsp',
				-- enable = false,
			},
			{
				"zbirenbaum/copilot-cmp",
				config = true,
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		config = require "arfs6.configs.lsp_config".config,
		event = "VeryLazy",
		enabled = true,
	},

	{
		"NvChad/nvterm",
		config = require "arfs6.configs.nvterm".config,
		keys = require "arfs6.configs.nvterm".keys,
		enabled = true,
	},

	{
		'mfussenegger/nvim-lint',
		enabled = true,
		ft = 'tex',
		config = require("arfs6.configs.nvim-lint").config
	},

	{
		"lervag/vimtex",
		enabled = true,
		ft = "tex",
	},

	{
		"https://github.com/machakann/vim-sandwich",
		keys = require("arfs6.configs.sandwich").keys,
		config = require("arfs6.configs.sandwich").config,
		event = 'VeryLazy',
		enabled = true,
	},

	{
		"arfs6/keytones.nvim",
		dir = "~/proj/nvim/keytones.nvim",
		lazy = false,
		enabled = false,
		config = true,
	},
	{
		"hrsh7th/nvim-pasta",
		lazy = false,
		enabled = false,
		config = require 'arfs6.configs.nvim-pasta'.config
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		config = require("arfs6.configs.tokyonight").config,
	},

	{
		"zbirenbaum/copilot.lua",
		event = 'insertenter',
		cmd = 'Copilot',
		config = require('arfs6.configs.copilot').config,
	},

	{
		"theprimeagen/harpoon",
		config = require("arfs6.configs.harpoon"),
		keys = require("arfs6.configs.harpoon").keys,
		enabled = false,
	},

	{
		"stevearc/oil.nvim",
		config = require("arfs6.configs.oil").config,
		lazy = false,
	},

	{
		"tpope/vim-fugitive",
		cmd ={"Git", "G"},
	}
}
