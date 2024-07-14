return {
	"zbirenbaum/copilot.lua",
	name = "copilot",
	lazy = false,
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			panel = {
				enabled = true,
				auto_refresh = true,
				keymap = {
					jump_prev = "<M-k>",
					jump_next = "<M-j>",
					accept = "<M-l>",
					refresh = "<leader>gcr",
					open = "<M-CR>",
				},
				layout = {
					-- top | left | right | bottom
					position = "right",
					ratio = 0.4,
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = true,
				debounce = 75,
				keymap = {
					accept = "<M-l>",
					accept_word = false,
					accept_line = false,
					next = "<M-j>",
					prev = "<M-k>",
					dismiss = "<C-;>",
				},
			},
			-- Override some of the defaults
			filetypes = {
				yaml = true,
				markdown = true,
				help = false,
				gitcommit = false,
				gitrebase = false,
				hgcommit = false,
				svn = false,
				cvs = false,
				["."] = false,
			},
			copilot_node_command = "node", -- Node.js version must be > 18.x
			server_opts_overrides = {},
		})
	end,
}
