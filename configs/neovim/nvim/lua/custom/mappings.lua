---@type MappingsTable
local M = {}

M.disabled = {
				n = {
								["<C-n>"] = "",
				},
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}

-- more keybinds!

M.nvimtree = {
				plugin = true,

				n = {
								["<A-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
				},
}

return M
