local m = {}

m.config = function()
	require('copilot').setup({
		panel = {
			layout = {
				ratio = 0.3,
			}
		}
	})
end

return m
