local m = {}

local options = {
	texlab = {
		settings = {
			texlab = {
				build = {
					onSave = false,
					build = nil,
				},
			},
		},
	},

	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				diagnostics = {
					globals = { "vim" },
				},
				completion = {
					callSnippet = "Replace",
				},
			},
		},
	},

	html = {
		filetypes = {
			"html",
			"templ",
			"htmldjango",
		},
	},
}

local function command_available(server)
	local config = vim.lsp.config[server]
	local cmd = config and config.cmd

	if type(cmd) == "string" then
		return vim.fn.executable(cmd) == 1
	end

	return type(cmd) == "table" and cmd[1] ~= nil and vim.fn.executable(cmd[1]) == 1
end

m.config = function()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	vim.lsp.config("*", { capabilities = capabilities })

	A.missing_lsp_servers = {}

	for _, server in ipairs(A.servers) do
		vim.lsp.config(server, options[server] or {})

		if command_available(server) then
			vim.lsp.enable(server)
		else
			table.insert(A.missing_lsp_servers, server)
		end
	end
end

return m
