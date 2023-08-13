-- install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
   })
end
vim.opt.rtp:prepend(lazypath)

opts = {
defaults = {
	lazy = true,
},
dev = {
	path = "~/proj/nvim",
},
ui = {
	custom_keys = {
		["<localleader>l"] = nil,
		["<localleader>t"] = nil,
		          -- open lazygit log
          ["<localleader>ll"] = function(plugin)
            require("lazy.util").float_term({ "lazygit", "log" }, {
              cwd = plugin.dir,
            })
          end,
    
          -- open a terminal for the plugin dir
          ["<localleader>lt"] = function(plugin)
            require("lazy.util").float_term(nil, {
              cwd = plugin.dir,
            })
          end,
        },
},
}

-- load pluginsddpddp
require("lazy").setup(A.plugins, opts)
