# Neovim  
My neovim config contain several files (lua modules). It was inspired by the nvchad distro. It has my mappings and more plugins.  
## Trying  
If you want to try my config, just copy the [arfs6](./arfs6) directory to your `lua/` directory in your config directory. i.e. `~/.config/nvim/lua` directory for linux. Then require it in your init.lua.  
```lua
require "arfs6"
```  
Since the `lua` directory is automatically added to the runtime path, no need of specifying it.  
## update.sh  
I use the `[update.sh](./update.sh)` file to update the config.  
