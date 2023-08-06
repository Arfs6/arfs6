return {
	config = function()
		local lsp = require "lspconfig"
		for idx = 1, #A.servers, 1 do
			lsp[A.servers[idx]].setup{}
		end
	end,
}
