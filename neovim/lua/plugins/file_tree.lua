-- Uses nvim-tree
local keymap_opts = { noremap=true, unique=true, silent=true }

return {
  "nvim-tree/nvim-tree.lua",
  name = "nvim-tree",
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
  },
  config = function()
    require("nvim-tree").setup {
      auto_reload_on_write = true,
      disable_netrw = true,
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
        icons = {
          web_devicons = {
            file = {
              enable = true,
              color = true,
            },
            folder = {
              enable = true,
              color = true,
            },
          },
        },
      },
      filters = {
        dotfiles = false,
        git_ignored = true,
        exclude = {},
      },
    }

    local api = require "nvim-tree.api"
    vim.keymap.set("n", "<leader>nt", api.tree.toggle, keymap_opts)
    vim.keymap.set("n", "<leader>nr", api.tree.reload, keymap_opts)
    vim.keymap.set("n", "<leader>nf", api.tree.find_file, keymap_opts)
    vim.keymap.set("n", "<leader>nc", api.tree.collapse_all, keymap_opts)
  end,
}

