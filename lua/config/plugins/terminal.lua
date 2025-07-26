return {
	{
		"numToStr/FTerm.nvim",
		config = function()
			require("FTerm").setup({
				blend = 10,
				dimensions = {
					height = 0.85,
					width = 0.85,
					x = 0.5,
					y = 0.5
				},
				border = 'rounded',
				theme = {
					background = '#1E1E2E', -- Catppuccin "base" (dark)
					foreground = '#CDD6F4', -- Catppuccin "text"
					border     = '#F5E0DC', -- Catppuccin "rosewater" (accent)
				},
			})
		end,
		keys = {
			{ "<A-i>", function() require("FTerm").toggle() end, desc = "Toggle FTerm" },
		},
	},
}
