local vim = vim
A = {}

-- lsp and mason servers
A.servers = {
	'lua_ls',
	'clangd',
	'cssls',
	'html',
	'ruff',
	'yamlls',
	'pyright',
	"bashls",
	-- "texlab", -- I don't need this at the moment
}

require "arfs6.options"
require "arfs6.mappings"
local plugins = require "arfs6.plugins"
require "arfs6.lazy_config".load_plugins(plugins)
require("arfs6.commands")

A.p = function(obj)
	print(vim.inspect(obj))
end
