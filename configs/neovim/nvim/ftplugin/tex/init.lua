A.tex = {}
vim.b.tex_flavor = [[make4ht -x -u -a info $* mathml,mathjax,frame,next]]
vim.g.vimtex_compiler_latexmk = {
	-- aux_dir = "/tmp/tex/aux/",
	out_dir = "/tmp/tex/out/",
}
vim.g.vimtex_indent_enabled = 0
-- vim.g.vimtex_complete_enabled = 0
-- vim.g.vimtex_imaps_enabled = 0
vim.g.vimtex_quickfix_autoclose_after_keystrokes = 6
vim.g.vimtex_view_enabled = 0
vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
	-- pattern = "*.tex",
	callback = vim.cmd.VimtexClean,
})

-- compile tex files
-- Function to change the extension of the file path to .html or add it if missing
local changeExtToHtml = function(filePath)
	-- Check if the file exists before proceeding
	local fileHandle, err = io.open(filePath, "r")
	if fileHandle then
		fileHandle:close()
	else
		vim.print("File doesn't exist:", filePath)
		return
	end
	local filename, extension = filePath:match("^(.-)(%..-)$")
	if not extension then
		filename = filePath
		extension = ".html"
	elseif extension ~= ".html" then
		extension = ".html"
	else
		return filePath -- File already has .html extension, no need to change it
	end

	return filename .. extension
end

local compile = function()
	local fileName = vim.api.nvim_buf_get_name(vim.fn.bufnr())
	if fileName == "" then
		print("File doesn't exists or haven't been saved.")
		return
	end

	A.tex.compilerId = vim.fn.jobstart {
		"make4ht",
		"-x",
		"-u",
		fileName,
		-- "html,frame,3,next,mathjax",
		"html,frame,next,mathjax",
	}
end
vim.keymap.set('n', '<leader>ac', function()
	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		pattern = "*.tex",
		callback = compile
	})
	vim.print("Auto compilation started.")
	vim.keymap.set('n', '<leader>ac', function()
		print("Autocompilation already started.")
	end)
end)
vim.keymap.set('n', '<F5>', compile)
