local KEYMAP_OPTS = { noremap = true, unique = false, silent = true }

return {
	"lewis6991/gitsigns.nvim",
	name = "gitsigns",
	config = function()
		require("gitsigns").setup({
			signs_staged_enable = true,

			-- Keymappings. Using only the hunk preview for now (Used to preview the git signs status on the left)
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")
				KEYMAP_OPTS["buffer"] = bufnr
				vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, KEYMAP_OPTS)
			end,
		})
	end,
}
