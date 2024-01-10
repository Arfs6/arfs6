return {
	config = function()
		local ls = require"luasnip"
		ls.setup{}
		require("luasnip.loaders.from_vscode").lazy_load()
		vim.keymap.set({"i"}, "<c-k>", function() ls.expand() end, {silent = true})
		vim.keymap.set({"i", "s"}, "<c-l>", function() ls.jump( 1) end, {silent = true})
		vim.keymap.set({"i", "s"}, "<c-j>", function() ls.jump(-1) end, {silent = true})

		vim.keymap.set({"i", "s"}, "<c-e>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, {silent = true})
		vim.print("loading lua snip...")
	end
}
