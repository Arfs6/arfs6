local m = {}

local options = {
	texlab = {
	settings = {
		texlab = {
			build = {
				onSave = false,
				build = nil,
			}
		}
	}
},

	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					version = 'LuaJIT',
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = {'vim'},
				},
				completion = {
					callSnippet = "Replace"
				},
			},
		},
	}

}

m.config = function()
	local lsp = require'lspconfig'
	for idx, server in ipairs(A.servers) do
		idx = idx  -- mute lsp
		local opts = options[server]
		if opts == nil then
			opts = {}
		end
		vim.schedule(function()
		lsp[server].setup(opts)
		end)
	end
end

return m
