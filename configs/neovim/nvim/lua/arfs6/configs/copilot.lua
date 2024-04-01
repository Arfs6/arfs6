local m = {}

m.config = function()
	require('copilot').setup({
		suggestion = {
			enabled=false,
		},
		panel = {
			enabled=false,
			layout = {
				ratio = 0.3,
			}
		}
	})
end

return m
