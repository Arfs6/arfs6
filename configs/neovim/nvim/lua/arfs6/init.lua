local vim = vim
A = {}

-- lsp and mason servers
A.servers = {
	'lua_ls',
	'pyright',
	"bashls",
	"texlab",
}

require "arfs6.options"
require "arfs6.mappings"
A.plugins = require "arfs6.plugins"
require "arfs6.lazy_config"

A.p = function(obj)
	print(vim.inspect(obj))
end
