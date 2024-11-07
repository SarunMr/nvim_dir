local opts = {
  ensure_installed ={
    "efm",
    "lua_ls",
    "java",
    "python",
  },
  automatic_installation = true,
}

return{
  "williamboman/mason-lspconfig.nvim",
  opts=opts,
  event="BufReadPre",
  dependencies ="williamboman/mason.nvim",
}
