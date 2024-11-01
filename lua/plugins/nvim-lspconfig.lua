local on_attach = require("utils.lsp")
local config = function()
require("neoconf").setup({})
	local lspconfig = require("lspconfig")

	local signs = { Error = "x", Warn = "!", Hint = "+", Info = "i" }
	for type, icon in pairs(signs) do
		local hl = "diafnosticsign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, niumhl = "" })
	end

	--lua
	lspconfig.lua_ls.setup({
    on_attach =on_attach.on_attach,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})
	--python

	lspconfig.pyright.setup({
    on_attach =on_attach.on_attach,
		settings = {
			pyright = {
				disableOrganizeImports =false,
analysis={
useLibraryCodeForTypes =true,
autoSearchPaths=true,
diagnosicMode="workspace",
autoImprtCompletions=true,
				},
			},
		},
	})

	local luacheck = require("efmls-configs.linters.luacheck") --lua linter
	local stylua = require("efmls-configs.formatters.stylua") --lua formatter
	local flake8 = require("efmls-configs.linters.flake8")--py
	local black = require("efmls-configs.formatters.black")--py

	-- config efm server
	lspconfig.efm.setup({
		filetypes = {
			"lua",
      "python",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				lua = { luacheck, stylua },
        python ={flake8,black},
			},
		},
	})

	local lsp_fmt_group = vim.api.nvim_create_augroup("LspForamattingGroup", {})
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = lsp_fmt_group,
		callback = function()
			local efm = vim.lsp.get_active_clients({ name = "efm" })
			if vim.tbl_isempty(efm) then
				return
			end
			vim.lsp.buf.format({ name = "efm" })
		end,
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
	},
}
