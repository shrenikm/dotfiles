return {
	"lewis6991/gitsigns.nvim",
	name = "gitsigns",
	config = function()
		require("gitsigns").setup({
			signs_staged_enable = true,
		})
	end,
}
