return {
	"sindrets/diffview.nvim",
	name = "diffview",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", enabled = true },
	},
	config = function()
		local actions = require("diffview.actions")

		require("diffview").setup({
			diff_binaries = false,
			use_icons = true,
      -- NOTE: Requires git version > 2.25.1 as diffview doesn't seem to detect older versions.
      git_cmd = { "git" },
		})
	end,
}
