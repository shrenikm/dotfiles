return {
  "NeogitOrg/neogit",
  name = "neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    -- TODO: Config
    require("neogit").setup()
  end,
}
