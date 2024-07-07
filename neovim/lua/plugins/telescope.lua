local keymap_opts = { noremap=true, unique=true, silent=true }

return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    build = "make",
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  opts = {
    
  },
  config = function()
    require("telescope").setup{
      defaults = {
        mappings = {
          i = {
            ["<C-h>"] = "which_key"
          }
        }
      },
      pickers = {},
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        }
      },
    }
    require("telescope").load_extension("ui-select")

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, keymap_opts)
    vim.keymap.set("n", "<leader>fs", builtin.grep_string, keymap_opts)
    vim.keymap.set("n", "<leader>fl", builtin.live_grep, keymap_opts)
    vim.keymap.set("n", "<leader>fb", builtin.buffers, keymap_opts)
    vim.keymap.set("n", "<leader>fo", builtin.oldfiles, keymap_opts)
    vim.keymap.set("n", "<leader>fc", builtin.command_history, keymap_opts)
    vim.keymap.set("n", "<leader>fg", builtin.git_status, keymap_opts)
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, keymap_opts)
  end,
}
