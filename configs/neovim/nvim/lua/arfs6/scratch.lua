--[[ A scratch buffer.
Used for writing temporary text. ]]
local scratchBufferName = "Scratch" -- Buffer name for scratch buffer.
local function scratch()
	local bufNo = vim.fn.bufnr(scratchBufferName)
	if bufNo ~= -1 then
		vim.notify("Buffer exists!")
		return
	end
end
