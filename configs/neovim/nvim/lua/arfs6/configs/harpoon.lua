local m = {}

m.config = function()
	vim.keymap.set({"n"}, "<leader>hm", require("harpoon.mark").add_file())
end

m.keys = {
	"<leader>hm",
}

return m
