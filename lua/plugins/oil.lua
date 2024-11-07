return {
	"stevearc/oil.nvim",
	opts = {},
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	config = function()
		local keymap = vim.keymap
		keymap.set("n", "<leader>e", ":Oil<CR>")
	end,
}
