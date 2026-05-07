return {
	{
		"windwp/nvim-autopairs",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-autopairs").setup({ check_ts = true })
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_close_on_slash = true,
					enable_rename = false,
				},
			})
		end,
	},
}
