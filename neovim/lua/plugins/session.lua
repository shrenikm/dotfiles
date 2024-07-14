return {
	{
		"rmagatti/auto-session",
		dependencies = {
			"nvim-telescope/telescope.nvim", -- For sessions picker/lens
		},
		config = function()
			require("auto-session").setup({
				auto_session_enabled = true,
				auto_session_enable_last_session = true,
				auto_session_suppress_dirs = { "/", "~/Downloads" },
			})
		end,
	},
}
