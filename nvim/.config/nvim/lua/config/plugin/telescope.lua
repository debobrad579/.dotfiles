return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local telescope = require("telescope")
			telescope.load_extension("fzf")
			telescope.load_extension("ui-select")
		end,
		keys = {
			{
				"<C-p>",
				function()
					require("telescope.builtin").git_files()
				end,
			},
			{
				"<leader>pf",
				function()
					require("telescope.builtin").find_files()
				end,
			},
			{
				"<leader>ps",
				function()
					require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
				end,
			},
		},
	},
	"nvim-telescope/telescope-ui-select.nvim",
}
