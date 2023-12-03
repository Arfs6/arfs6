local vim = vim
A = {}

-- lsp and mason servers
A.servers = {
	'lua_ls',
	'clangd',
	'cssls',
	-- 'html',
	'ruff_lsp',
	'yamlls',
	'pyright',
	"bashls",
	"texlab",
}

require "arfs6.options"
require "arfs6.mappings"
require"arfs6.autocmd"
A.plugins = require "arfs6.plugins"
require "arfs6.lazy_config"
A._scratch = require "arfs6.scratch"

A.p = function(obj)
	print(vim.inspect(obj))
end
