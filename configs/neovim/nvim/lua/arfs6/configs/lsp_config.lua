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
					globals = { 'vim' },
				},
				completion = {
					callSnippet = "Replace"
				},
			},
		},
	},

	html = {
		filetypes = {
			"html",
"templ" ,
"htmldjango",
		},
	},

}

m.config = function()
	local capabilities = require('cmp_nvim_lsp').default_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	vim.lsp.config('*', {capabilities = capabilities})
	for idx, server in ipairs(A.servers) do
		idx = idx -- mute lsp
		-- require("lspconfig")[server].setup(options[server] or {})
		vim.lsp.config(server, options[server] or {})
	end
end

return m
