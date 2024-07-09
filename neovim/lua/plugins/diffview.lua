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
		})
	end,
}
