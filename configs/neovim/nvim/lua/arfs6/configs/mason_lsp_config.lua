local m = {}

local ensure_installed = {}
local table = require'table'

for i, v in ipairs(A.servers) do
	table.insert(ensure_installed, v)
end

	m.config = function()
		require("mason-lspconfig").setup {
			ensure_installed = ensure_installed,
			automatic_installation = true,
		}
	end

return m
