return {
	config = function()
		require("mason-lspconfig").setup {
			ensure_installed = A.servers,
			automatic_installation = true,
		}
	end,
}
