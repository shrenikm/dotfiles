-- Required parsers
required_parsers = { "vim", "vimdoc", "markdown", "cmake", "c", "cpp", "python", "bash", "lua", "luadoc", "regex", "yaml" }

return {
  "nvim-treesitter/nvim-treesitter",
  name = "nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = required_parsers,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    }
  end
}

