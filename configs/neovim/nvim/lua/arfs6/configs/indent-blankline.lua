local m = {}

m.config = function()
require('ibl').setup({
indent = {
char = '|',
},
})
end

return m
