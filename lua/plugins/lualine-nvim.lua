local config = function() 
local theme = require("lualine.themes.night-owl")
theme.normal.c.bg = nil

require('lualine').setup{
options ={
theme = theme,globalstauts = true,
},
sections ={
lualine_a = {
{'buffers',}
},
},
}
end

return {"nvim-lualine/lualine.nvim",lazy=false,
config=config,}
