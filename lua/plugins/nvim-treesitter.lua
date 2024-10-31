local config = function()
  require("nvim-treesitter.configs").setup({
    indent ={
      enable= true,
    },
    autotag ={
      enable= true,
    },
    ensure_installed ={
      "markdown",
      "json",
      "javascript",
      "typescript",
      "yaml",
      "html",
      "css",
      "markdown",
      "bash",
      "lua",
      "dockerfile",
      "solidity",
      "gitignore",
      "c",
      "python",
      "rust",
      "java",
      "c_sharp",
      "dart",
    },
    auto_install = true,
    highlight ={
    enable=true,
    additional_vim_regex_highlighting = false,
  },
    })
  end

  return{
    "nvim-treesitter/nvim-treesitter",
    lazy=false,
    config = config
  }
