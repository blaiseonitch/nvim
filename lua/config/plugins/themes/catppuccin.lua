return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,                 -- Load immediately (not lazy-loaded)
		priority = 1000,              -- Load before other plugins
		opts = {
			flavour = "macchiato",      -- "latte", "frappe", "macchiato", or "mocha"
			transparent_background = true, -- Set to true for transparency
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				telescope = true,
				lsp_trouble = true,
				-- Enable more integrations as needed (see docs)
			},
		},
		-- config = function(_, opts)
		-- 	require("catppuccin").setup(opts)
		-- 	vim.cmd.colorscheme("catppuccin") -- Apply the theme
		-- end,
	}
}
