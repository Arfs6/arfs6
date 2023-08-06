local vim = vim
vim.g.mapleader = ' '
vim.keymap.set({'i', 'v'}, 'jj', '<ESC>')
vim.keymap.set('n', ';', ':')
vim.keymap.set('t', 'jj', '<C-\\><C-n>')
vim.keymap.set('n', '<leader>tb', ':tabe | terminal bash<cr>')
vim.keymap.set('n', '<leader>t', ':tabe<cr>')
vim.keymap.set('n', '<leader>s', ':w<cr>')

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		--[[ vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts) ]]
		vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})

-- compile tex files
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
	pattern = "*.tex",
	callback = function(args)
		-- Function to change the extension of the file path to .html or add it if missing
		local changeExtToHtml = function(filePath)
			-- Check if the file exists before proceeding
			local fileHandle, err = io.open(filePath, "r")
			if fileHandle then
				fileHandle:close()
			else
				vim.print("File doesn't exist:", file)
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
				print("File doesn't exists")
				return
			end
			local newFile = changeExtToHtml(fileName)

			vim.fn.system{
				"pandoc",
				"-s",
				"--mathml",
				"-f",
				"latex",
				"-t",
				"html",
				"-o",
				newFile,
				fileName,
			}
		end

		vim.keymap.set('n', '<f5>', compile)
	end
})
