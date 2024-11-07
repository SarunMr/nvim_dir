local on_attach = require("utils.lsp")
local config = function()
	require("neoconf").setup({})
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local lspconfig = require("lspconfig")
	local capabilities = cmp_nvim_lsp.default_capabilities()

	local signs = { Error = "x", Warn = "!", Hint = "+", Info = "i" }
	for type, icon in pairs(signs) do
		local hl = "diafnosticsign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, niumhl = "" })
	end
	local capabilities = cmp_nvim_lsp.default_capabilities()

	--lua
	lspconfig.lua_ls.setup({
		on_attach = on_attach.on_attach,
		capabilities = capabilities,
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
		capabilities = capabilities,
		on_attach = on_attach.on_attach,
		settings = {
			pyright = {
				disableOrganizeImports = false,
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosicMode = "workspace",
					autoImprtCompletions = true,
				},
			},
		},
	})

--java
	lspconfig.jdtls.setup({
		capabilities = capabilities,
		on_attach = on_attach.onattach,
	})

--typescript

lspconfig.ts_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach.on_attach,
    filetypes = {
      "typescript"
},
root_dir =lspconfig.util.root_pattern("package.json","tsconfig.json",".gi"),
	})

	local luacheck = require("efmls-configs.linters.luacheck") --lua linter
	local stylua = require("efmls-configs.formatters.stylua") --lua formatter
	local flake8 = require("efmls-configs.linters.flake8") --py
	local black = require("efmls-configs.formatters.black") --py
	local eslint_d = require("efmls-configs.linters.eslint_d") --py
	-- local prettier_d = require("efmls-configs.formatters.prettier_d ") --py

	-- config efm server
	lspconfig.efm.setup({
		filetypes = {
			"lua",
			"python",
			"java",
      "typescript"
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
				python = { flake8, black },
        typescript ={eslint_d},
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
		"hrsh7th/cmp-nvim-lsp",
	},
}
