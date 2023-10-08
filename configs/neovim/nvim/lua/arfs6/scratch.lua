--[[ A scratch buffer.
Used for writing temporary text. ]]
m = {}
local function findBufNo(bufName)
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local currentBuf = vim.api.nvim_buf_get_name(buf)
		if currentBuf == bufName then
			return buf
		end
	end
	return -1
end
local function scratch()
	if m.bufName == nil then
	m.bufName = 'Scrap Paper'
	end
	if m.prevBuf ~= nil then
		local prevBufNo = findBufNo(m.prevBuf)
		if prevBufNo ~= -1 then
			-- Set it to current buffer.
		vim.api.nvim_set_current_buf(prevBufNo)
		m.prevBuf = nil
			else
			vim.api.nvim_buf_delete(vim.api.nvim_get_current_buf(), {})
		end
		return
	end
	local bufNo = findBufNo(m.bufName)
	if bufNo ~= -1 then
		m.prevBuf = vim.api.nvim_buf_get_name(0)
		vim.api.nvim_set_current_buf(bufNo)
		return
	end
	local scratchBufHandle = vim.api.nvim_create_buf(flase, true)
	vim.api.nvim_buf_set_name(scratchBufHandle, m.bufName)
	m.bufName = vim.api.nvim_buf_get_name(scratchBufHandle) -- bufname get changed to cwd/bufname.
	vim.api.nvim_create_autocmd('BufLeave', {
		buffer=scratchBufHandle,
		callback = function()
		A._scratch.prevBuf = nil
		end
	})
	m.prevBuf = vim.api.nvim_buf_get_name(0)
	vim.api.nvim_set_current_buf(scratchBufHandle)
end

vim.keymap.set('n', '<leader>sc', scratch)
A.findBufNo = findBufNo
return m
