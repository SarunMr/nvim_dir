local keymap = vim.keymap

local opts = { noremap = true, silent = true }

--Pane Navigation
keymap.set("n", "<C-h>", "<C-w>h", opts) --Navigate Left
keymap.set("n", "<C-j>", "<C-w>j", opts) --Navigate Down
keymap.set("n", "<C-k>", "<C-w>k", opts) --Navigate Up
keymap.set("n", "<C-l>", "<C-w>l", opts) --Navigate Right

--Window Management

keymap.set("n", "<leader>sv", ":vsplit<CR>", opts) --Split Vertically
keymap.set("n", "<leader>e", ":oil<cr>", opts) --Split Vertically
keymap.set("n", "<leader>sh", ":split<CR>", opts) --Split Horizontally
keymap.set("n", "<leader>q", ":bp | bd #<CR>", opts)
-- Indenting

keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Comments

vim.api.nvim_set_keymap("n", "<C-_>", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<C-_>", "gcc", { noremap = false })

