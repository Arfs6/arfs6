local function see(opts)
	vim.ui.open(opts.args)
end
vim.api.nvim_create_user_command("See", see, {
	nargs = 1,
	complete = "file",
})
