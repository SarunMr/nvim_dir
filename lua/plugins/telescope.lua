local keymap = vim.keymap
local config = function()
  local telescope = require('telescope')
  telescope.setup({

    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = "move_selection-next",
          ["<C-k>"] = "move_selection-previous",

        },
      },
    },
    pickers = {
      find_files = {
        theme = "dropdown",
        previewr = "false",
        hidden = true
      },
      live_grep = {
        theme = "dropdown",
        previewr = "false",
      },
      find_buffers = {
        theme = "dropdown",
        previewr = "false",
      },
    },
  })
end


return {
  'nvim-telescope/telescope.nvim', 
  tag = '0.1.8',
  lazy=true,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = config,
  keys ={
    keymap.set("n","<leader>fk",":Telescope keymaps<CR>"),
    keymap.set("n","<leader>fh",":Telescope help_tags<CR>"),
    keymap.set("n","<leader>ff",":Telescope find_files<CR>"),
    keymap.set("n","<leader>fg",":Telescope live_grep<CR>"),
    keymap.set("n","<leader>fb",":Telescope buffers<CR>"),
  },
}






















