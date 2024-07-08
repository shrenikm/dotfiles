local KEYMAP_OPTS = { noremap = true, unique = false, silent = true }

return {
  "nvimtools/none-ls.nvim",
  name = "none-ls",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        --null_ls.builtins.code_actions.refactoring,

        -- Formatters (MAKE SURE THESE ARE INSTALLED THROUGH MASON)
        -- For lua
        null_ls.builtins.formatting.stylua,
        -- For CMake
        null_ls.builtins.formatting.cmake_format,
        -- For C/C++
        null_ls.builtins.formatting.clang_format,
        -- For python
        null_ls.builtins.formatting.black,
        -- For python imports
        null_ls.builtins.formatting.isort,
        -- For codeblocks inside markdown
        null_ls.builtins.formatting.cbfmt,
        -- For markdown linting (Could optionally use mdformat)
        null_ls.builtins.formatting.markdownlint,
        -- For bash
        null_ls.builtins.formatting.shfmt,
        -- For yaml
        null_ls.builtins.formatting.yamlfmt,
      },
    })

    -- Keybindings
    vim.keymap.set("n", "<space>f", vim.lsp.buf.format, KEYMAP_OPTS)
  end,
}
