---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "onedark",
  theme_toggle = { "onedark", "one_light" },
  statusline = {
    -- theme = "minimal",
    -- separator_style = "block",
				-- 				overriden_modules = function(modules)
				-- 								modules[2] = (function()
				-- 												return ""
				-- 								end)()
    -- end,
				},

  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
