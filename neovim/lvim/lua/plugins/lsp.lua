return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = {
              logLevel = "error",
            },
          },
          -- `<leader>co` is bound globally in keymaps.lua so diffview's
          -- buffer-local `<leader>co` (conflict_choose("ours")) wins inside
          -- a diffview tab without a per-LSP buffer-local binding racing it.
        },
        -- Basedpyright with settings to make it less noisy/annoying
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "standard",
                diagnosticSeverityOverrides = {
                  reportAny = "none",
                  reportExplicitAny = "none",
                  reportMissingTypeArgument = "none",
                  reportPrivateLocalImportUsage = "none",
                  reportUnannotatedClassAttribute = "none",
                  reportUnusedCallResult = "none",
                },
                -- Keep parameter-name hints (the "foo=" labels next to args
                -- in function calls); kill every type-annotation ghost.
                inlayHints = {
                  callArgumentNames = false,
                  variableTypes = false,
                  functionReturnTypes = false,
                  genericTypes = false,
                },
              },
            },
          },
        },
        harper_ls = {
          filetypes = { "vim", "lua", "cmake", "c", "cpp", "python", "sh", "yaml", "xml", "markdown", "text", "toml" },
          settings = {
            ["harper-ls"] = {
              linters = {
                LongSentences = false,
              },
            },
          },
        },
        -- copilot.lua only works with its own copilot lsp server
        copilot = { enabled = false },
      },
    },
  },
}
