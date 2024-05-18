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
	local lsp = require 'lspconfig'
	local capabilities = require('cmp_nvim_lsp').default_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	for idx, server in ipairs(A.servers) do
		idx = idx -- mute lsp
		local opts = options[server]
		if opts == nil then
			opts = {}
		end
		opts.capabilities = capabilities
		lsp[server].setup(opts)
	end
	--[[ vim.api.nvim_create_autocmd({ 'VimEnter', }, {
		callback = function()
			vim.schedule(function()
				vim.wait(2000, function()
					vim.cmd('LspStart')
					return vim.lsp.buf.server_ready()
				end)
			end)
		end
	}) ]]
end

return m
